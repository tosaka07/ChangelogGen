import ArgumentParser
import Rainbow
import PathKit
import Rainbow
import Yams

struct GenerateCommand: ParsableCommand {
    
    static var configuration: CommandConfiguration = CommandConfiguration(commandName: "generate")

    static let defaultFile = "changeloggen.yml"
    static let defaultFormat = "{title} #{number} @{user}"
    
    @Option(name: .long, help: "GitHub access token.")
    var token: String

    @Option(name: .shortAndLong, help: "Milestone title.")
    var milestone: String

    @Option(name: .shortAndLong, help: "The path to the spec file. Defaults to \(defaultFile)")
    var spec: String?

    @Option(name: .shortAndLong, help: "The repositorie that generate change logs. Format is 'owner/repo'")
    var target: String?

    @Option(name: .shortAndLong, help: "Labels to filter issues. Format is 'AAAA,BBBB'.", transform: {
        $0.split(separator: ",").map(String.init)
    })
    var labels: [String]?

    @Option(name: NameSpecification.customLong("labels-prefix"), help: "Characters to filter when outputting label sections..")
    var labelsPrefix: String?

    @Option(name: .shortAndLong, help: "Format of changes. Defaults to '\(defaultFormat)'")
    var format: String?

    @Option(name: .long, help: "Prefix")
    var prefix: String?

    @Option(name: .long, help: "Suffix")
    var suffix: String?

    @Flag(name: .shortAndLong, help: "")
    var verbose: Bool = false

    func loadSpec(path: Path) throws -> Spec {
        guard path.exists else {
            throw ValidationError("Not exists a spec file \(path.absolute())")
        }

        if verbose {
            print("Spec exists here! \(path)")
        }

        let data = try path.read()
        let decoder = YAMLDecoder()
        return try decoder.decode(Spec.self, from: data)
    }
                     
    func run() throws {
        var spec = Spec()

        let defaultPath = Path.current + Self.defaultFile
        if let specPath = self.spec {
            let specPath = (Path.current + specPath).normalize().absolute()
            spec = try loadSpec(path: specPath)
        } else if defaultPath.exists {
            spec = try loadSpec(path: defaultPath)
        }

        if let target = self.target {
            spec.target = target
        }

        if let labels = self.labels, !labels.isEmpty {
            spec.labels = .init(label: labels, prefix: spec.labels?.prefix)
        }

        if let labelsPrefix = self.labelsPrefix {
            if var labels = spec.labels {
                labels.prefix = labelsPrefix
                spec.labels = labels
            }
        }

        if let format = self.format {
            spec.format = format
        }

        if spec.format == nil {
            spec.format = Self.defaultFormat
        }

        if let prefix = self.prefix {
            spec.prefix = prefix
        }

        if let suffix = self.suffix {
            spec.suffix = suffix
        }

        if verbose {
            info("\(spec)")
        }

        guard let target = spec.formattedTarget else {
            throw ValidationError("Missing expected argument '--target <owner/repo>' or configuration file.")
        }

        let api = GitHubAPI(config: .init(token: token))
        let milestones = try api.milestones(owner: target.owner, repo: target.repo).get()

        guard let specificMilestone = milestones.first(where: { $0.title == milestone }) else {
            throw ValidationError("Not found a milestone with title '\(milestone)'.")
        }

        let issues = try api.issues(owner: target.owner, repo: target.repo, state: .all, milestone: specificMilestone.number).get()

        let changes = issues
            .filter { issue in
                if let specificLabels = spec.labels?.label, !specificLabels.isEmpty {
                    return issue.labels
                        .contains(where: { label in specificLabels.contains(label.name) })
                }
                return true
            }
            .map(Changes.init(issue:))
            

        if verbose {
            print(changes.count)
        }

        let changelog = Changelog(changes: changes, spec: spec)

        print(changelog.generate())

        if verbose {
            success("Finish Runnning GenerateCommand.")
        }

    }

    func info(_ text: String) {
        print(text)
    }

    func success(_ text: String) {
        print(text.green)
    }

    func warn(_ text: String) {
        print(text.yellow)
    }

    func error(_ text: String) {
        print(text.red)
    }
}

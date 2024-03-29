import ArgumentParser

public struct ChangelogGenCommand: ParsableCommand {
    public static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "changeloggen",
        abstract: "A changelog generator.",
        version: "0.0.5",
        shouldDisplay: true,
        subcommands: [GenerateCommand.self],
        defaultSubcommand: GenerateCommand.self)
    
    public init() {}
}

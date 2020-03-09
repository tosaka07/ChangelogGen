import ArgumentParser

public struct ChangelogGenCommand: ParsableCommand {
    public static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "changeloggen",
        abstract: "A changelog generator.",
        subcommands: [GenerateCommand.self],
        defaultSubcommand: GenerateCommand.self)
    
    public init() {}
}

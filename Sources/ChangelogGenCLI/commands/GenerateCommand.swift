import ArgumentParser

struct GenerateCommand: ParsableCommand {
    
    static var configuration: CommandConfiguration = CommandConfiguration(commandName: "generate")
    
    @Option(name: .long, help: "Needs to access GitHub.")
    var accessToken: String
    
    @Option(name: .shortAndLong, default: "./changeloggen.yml", help: "Setting file path.")
    var path: String
                     
    func run() throws {
        print("Start Running GenerateCommand.")
        
        print("accessToken is \(accessToken)")
        print("path is \(path)")
        
        print("Finish Runnning GenerateCommand.")
    }
}

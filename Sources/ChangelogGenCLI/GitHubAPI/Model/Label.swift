//
//  Label.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct Label: Codable {
    var id: Int
    var nodeId: String
    var url: URL
    var name: String
    var color: String
    var `default`: Bool
    var description: String
}

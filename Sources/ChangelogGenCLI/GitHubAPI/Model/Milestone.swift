//
//  Milestone.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct MileStone: Codable {
    var url: URL
    var htmlUrl: URL
    var labelsUrl: URL
    var id: Int
    var nodeId: String
    var number: Int
    var title: String
    var description: String?
    var creator: User
    var openIssues: Int
    var closedIssues: Int
    var state: Openness
    var createdAt: Date
    var updatedAt: Date
    var dueOn: Date?
    var closedAt: Date?
}

//
//  Issue.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct Issue: Codable {
    var url: URL
    var repositoryUrl: URL
    var labelsUrl: String
    var commentsUrl: URL
    var eventsUrl: URL
    var htmlUrl: URL
    var id: Int
    var nodeId: String
    var number: Int
    var title: String
    var user: User
    var labels: [Label]
    var state: Openness
    var locked: Bool
    var assignee: User?
    var assignees: [User]?
    var milestone: MileStone?
    var comments: Int
    var createdAt: Date
    var updatedAt: Date?
    var closedAt: Date?
    var authorAssociation: String
    var body: String?
}

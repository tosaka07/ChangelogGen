//
//  User.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct User: Codable {
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: URL
    var gravatarId: String
    var url: URL
    var htmlUrl: URL
    var followersUrl: URL
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subscriptionsUrl: URL
    var organizationsUrl: URL
    var reposUrl: URL
    var eventsUrl: String
    var receivedEventsUrl: URL
    var type: String
    var siteAdmin: Bool
}

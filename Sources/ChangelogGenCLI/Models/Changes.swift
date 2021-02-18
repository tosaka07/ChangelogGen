//
//  Changes.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct Changes {
    let title: String
    let number: Int
    let user: String
    let labels: [String]

    init(issue: Issue) {
        title = issue.title
        number = issue.number
        user = issue.user.login
        labels = issue.labels.map(\.name)
    }

    func format(_ format: String) -> String {
        format
            .replacingOccurrences(of: "{title}", with: title)
            .replacingOccurrences(of: "{number}", with: "\(number)")
            .replacingOccurrences(of: "{user}", with: user)
    }
}

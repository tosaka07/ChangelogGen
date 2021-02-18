//
//  APIs.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

extension GitHubAPI {
    func issues(
        owner: String,
        repo: String,
        state: Openness? = nil,
        milestone: Int? = nil,
        labels: [String]? = nil
    ) -> Result<[Issue], ResponseError> {
        let endpoint = "/repos/{owner}/{repo}/issues"
            .replacingOccurrences(of: "{owner}", with: owner)
            .replacingOccurrences(of: "{repo}", with: repo)

        var queries = [String: String?]()
        if let state = state {
            queries["state"] = state.rawValue
        }
        if let milestone = milestone {
            queries["milestone"] = "\(milestone)"
        }
        if let labels = labels {
            queries["labels"] = labels.joined(separator: ",")
        }

        let request = Request<[Issue]>(
            endpoint: endpoint,
            method: "GET",
            parameters: .query(queries)
        )
        return self.request(request)
    }

    @discardableResult
    func milestones(owner: String, repo: String) -> Result<[MileStone], ResponseError> {
        let endpoint = "/repos/{owner}/{repo}/milestones"
            .replacingOccurrences(of: "{owner}", with: owner)
            .replacingOccurrences(of: "{repo}", with: repo)

        let request = Request<[MileStone]>(endpoint: endpoint, method: "GET")
        return self.request(request)
    }
}

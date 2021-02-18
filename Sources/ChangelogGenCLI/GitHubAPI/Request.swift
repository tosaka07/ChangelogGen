//
//  Request.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct Request<T: Decodable> {
    enum Parameters {
        case query([String: String?])
    }

    let endpoint: String
    let method: String
    let parameters: Parameters?

    init(endpoint: String, method: String, parameters: Request<T>.Parameters? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
    }

    func makeURLRequest(baseURL: URL, headers: [String: String]) -> URLRequest? {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)

        switch parameters {
        case .query(let queries):
            if !queries.isEmpty {
                let items = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
                components?.queryItems = items
            }
        default:
            break
        }

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method
        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}

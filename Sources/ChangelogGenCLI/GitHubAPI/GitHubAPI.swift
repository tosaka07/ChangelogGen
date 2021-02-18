//
//  GitHubAPI.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/18.
//

import Foundation

class GitHubAPI {

    struct Configuration {
        let token: String
    }

    let baseURL = URL(string: "https://api.github.com")!
    let config: Configuration
    let session: URLSession
    let semaphore = DispatchSemaphore(value: 0)

    let headers: [String: String]

    init(config: GitHubAPI.Configuration) {
        self.config = config
        self.session = URLSession(configuration: .ephemeral)
        self.headers = [
            "Accept": "application/vnd.github.v3+json",
            "Authorization": "token \(config.token)"
        ]
    }

    func request<T: Decodable>(_ request: Request<T>) -> Result<T, ResponseError> {
        var requestResponse: Result<T, ResponseError>!

        guard let request = request.makeURLRequest(baseURL: baseURL, headers: headers) else {
            return .failure(.other(NSError()))
        }
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            let result: Result<T, ResponseError>! = self?.handleResponse(response: response, data: data, error: error)
            requestResponse = result
            self?.semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        return requestResponse
    }

    private func handleResponse<T: Decodable>(response: URLResponse?, data: Data?, error: Error?) -> Result<T, ResponseError> {
        if let error = error {
            return .failure(.other(error))
        }

        if let response = response as? HTTPURLResponse, let data = data {
            switch response.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try decoder.decode(T.self, from: data)
                    return .success(result)
                } catch {
                    return .failure(.decoding(error))
                }
            case 400...499:
                return .failure(.response(response.statusCode, data))
            case 500...599:
                return .failure(.response(response.statusCode, data))
            default:
                return .failure(.response(response.statusCode, data))
            }
        }
        return .failure(.other(NSError()))
    }
}

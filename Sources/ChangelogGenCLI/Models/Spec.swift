//
//  Spec.swift
//  ArgumentParser
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

struct Spec: Codable {
    struct Target {
        var owner: String
        var repo: String

        init?(_ raw: String?) {
            guard let raw = raw else {
                return nil
            }
            let split = raw.split(separator: "/")
            if split.count != 2 {
                return nil
            }
            self.owner = String(split[0])
            self.repo = String(split[1])
        }
    }

    struct Labels: Codable {
        var label: [String]?
        var prefix: String?
    }

    var target: String?
    var labels: Labels?
    var format: String?
    var prefix: String?
    var suffix: String?

    var formattedTarget: Target? {
        return Target(target)
    }
}

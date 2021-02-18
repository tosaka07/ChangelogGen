//
//  ChangeLog.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

struct Changelog {
    var prefix: String?
    var changes: Either<[Changes], [KeyValue<Changes>]>
    var suffix: String?
    var format: String

    init(
        changes: [Changes],
        spec: Spec
    ) {
        self.prefix = spec.prefix
        self.suffix = spec.suffix
        self.format = spec.format!
        self.changes = {
            let filterLabels = spec.labels?.label ?? []
            if filterLabels.isEmpty {
                return .left(changes)
            }
            let keyValues = changes
                .reduce(into: [KeyValue<Changes>]()) { (result, changes) in
                    let label = changes.labels.first(where: filterLabels.contains)!
                    if let index = result.firstIndex(where: { $0.key == label }) {
                        result[index].value.append(changes)
                    } else {
                        result.append(.init(key: label, value: [changes]))
                    }
                }
                .sorted(by: { lhs, rhs in
                    if let lhsIndex = filterLabels.firstIndex(of: lhs.key),
                       let rhsIndex = filterLabels.firstIndex(of: rhs.key) {
                        return lhsIndex < rhsIndex
                    }
                    return false
                })
                .map { keyValue -> KeyValue<Changes> in
                    if let prefix = spec.labels?.prefix {
                        var tmp = keyValue
                        tmp.key = tmp.key.replacingOccurrences(of: prefix, with: "")
                        return tmp
                    }
                    return keyValue
                }
            return .right(keyValues)
        }()
    }

    func generate() -> String {
        var output: [String] = []

        if let prefix = prefix, !prefix.isEmpty {
            output.append(prefix)
        }

        let changesOutput: String
        switch changes {
        case .left(let (array)):
            changesOutput = array.map { "- \($0.format(format))" }.joined(separator: "\n")
        case .right(let array):
            changesOutput = array
                .map { "### \($0.key)\n\n\($0.value.map { "- \($0.format(format))" }.joined(separator: "\n"))" }
                .joined(separator: "\n\n")
        }
        output.append(changesOutput)

        if let suffix = suffix, !suffix.isEmpty {
            output.append(suffix)
        }

        return output.joined(separator: "\n\n")
    }
}

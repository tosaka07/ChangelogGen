//
//  Either.swift
//  ArgumentParser
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

enum Either<L, R> {
    case left(L)
    case right(R)

    var left: L? {
        if case .left(let left) = self {
            return left
        }
        return nil
    }

    var right: R? {
        if case .right(let left) = self {
            return left
        }
        return nil
    }
}

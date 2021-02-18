//
//  ResponseError.swift
//  ChangelogGenCLI
//
//  Created by 坂上 翔悟 on 2021/02/19.
//

import Foundation

enum ResponseError: Error {
    case response(Int, Data?)
    case decoding(Error)
    case other(Error)
}

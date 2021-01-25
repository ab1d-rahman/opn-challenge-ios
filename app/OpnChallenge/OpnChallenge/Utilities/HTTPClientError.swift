//
//  HTTPClientError.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 25/1/21.
//

import Foundation

public enum HTTPClientErrorType: Error {
    case parsingJSON
    case noInternetConnection
    case serverUnreachable
    case errorResponse(Int)
    case unknown
}

public struct HTTPClientError: Error {
    let errorType: HTTPClientErrorType
    let description: String?
}

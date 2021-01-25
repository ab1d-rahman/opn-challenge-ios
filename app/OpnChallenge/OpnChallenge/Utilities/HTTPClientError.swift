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

    var errorMessage: String {
        switch self.errorType {
        case .noInternetConnection:
            return "Could not connect to server. Please check your internet connection."
        case .serverUnreachable:
            return "Server unreachable. Please try again later."
        case .errorResponse(let statusCode):
            if statusCode == 500 {
                return "Server Error. Please try again later."
            }

            return "Something went wrong. Please try again later."
        default:
            return "Something went wrong. Please try again later."
        }
    }
}

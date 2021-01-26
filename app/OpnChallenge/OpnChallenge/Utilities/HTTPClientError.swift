//
//  HTTPClientError.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 25/1/21.
//

import Foundation

public enum HTTPClientErrorType {
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
            return "No internet error message".localized
        case .serverUnreachable:
            return "Server unreachable error message".localized
        case .errorResponse(let statusCode):
            if statusCode == Constants.HTTPStatusCodes.serverError {
                return "Server error message".localized
            }

            return "Something went wrong message".localized
        default:
            return "Something went wrong message".localized
        }
    }
}

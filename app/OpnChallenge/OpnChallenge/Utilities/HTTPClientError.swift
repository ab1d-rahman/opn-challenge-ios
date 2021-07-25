//
//  HTTPClientError.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 25/1/21.
//

import Foundation

public enum HTTPClientErrorType: Equatable {
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
        case .parsingJSON:
            return "Invalid response message".localized
        case .noInternetConnection:
            return "No internet error message".localized
        case .serverUnreachable:
            return "Server unreachable error message".localized
        case .errorResponse(let statusCode):
            switch statusCode {
            case Constants.HTTPStatusCodes.badRequest:
                return "Bad request message".localized
            case Constants.HTTPStatusCodes.serverError:
                return "Server error message".localized
            default:
                return "Something went wrong message".localized
            }
        default:
            return "Something went wrong message".localized
        }
    }
}

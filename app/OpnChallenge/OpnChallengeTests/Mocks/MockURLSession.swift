//
//  MockURLSession.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 28/1/21.
//

import Foundation
@testable import OpnChallenge

class MockURLSession: URLSessionProtocol {
    var completionHandlerData: (Data?, URLResponse?, Error?)!

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(completionHandlerData.0, completionHandlerData.1, completionHandlerData.2)

        return MockURLSessionDataTask()
    }
}

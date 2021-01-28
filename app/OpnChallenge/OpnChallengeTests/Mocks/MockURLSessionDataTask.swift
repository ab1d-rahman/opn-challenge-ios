//
//  MockURLSessionDataTask.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 28/1/21.
//

import Foundation
@testable import OpnChallenge

class MockURLSessionDataTask: URLSessionDataTask {
    let dummyString: String

    init(_ dummyString: String) {
        self.dummyString = dummyString
    }

    override func resume() {
        return
    }
}

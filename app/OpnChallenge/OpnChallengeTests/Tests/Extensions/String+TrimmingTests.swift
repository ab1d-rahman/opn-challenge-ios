//
//  String+TrimmingTests.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 27/1/21.
//

import XCTest
@testable import OpnChallenge

class String_TrimmingTests: XCTestCase {
    func testTrimmed() {
        let string = "   ABCD "
        XCTAssertEqual(string.trimmed, "ABCD")
    }

    func testContainsOnlyWhiteSpaceOrNewLine() {
        let stringA = "   "
        XCTAssertTrue(stringA.containsOnlyWhiteSpaceOrNewLine())

        let stringB = "   ABCD "
        XCTAssertFalse(stringB.containsOnlyWhiteSpaceOrNewLine())
    }
}

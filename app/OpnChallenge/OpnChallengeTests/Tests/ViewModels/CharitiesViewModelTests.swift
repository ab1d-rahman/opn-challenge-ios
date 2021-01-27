//
//  CharitiesViewModelTests.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 27/1/21.
//

import XCTest
@testable import OpnChallenge

class CharitiesViewModelTests: XCTestCase {
    var sut: CharitiesViewModel!
    var mockCharitiesService: MockCharitiesService!

    private let charitiesData = [Charity(id: 1, name: "A", logoURL: "url1"),
                                 Charity(id: 2, name: "B", logoURL: "url2"),
                                 Charity(id: 3, name: "C", logoURL: "url3")]

    override func setUp() {
        super.setUp()

        self.mockCharitiesService = MockCharitiesService()
        self.sut = CharitiesViewModel(charitiesService: mockCharitiesService)
    }

    func testCellViewModelsSetCorrectlyUponReceivingSuccessResponse() {
        self.mockCharitiesService.fetchCharitiesResponse = (self.charitiesData, nil)

        self.sut.fetchCharities()

        XCTAssertEqual(self.sut.numberOfCharities(), self.charitiesData.count)

        XCTAssertEqual(self.sut.getCellViewModel(at: 0).name, self.charitiesData[0].name)
        XCTAssertEqual(self.sut.getCellViewModel(at: 1).name, self.charitiesData[1].name)
        XCTAssertEqual(self.sut.getCellViewModel(at: 2).name, self.charitiesData[2].name)
    }

    func testCellViewModelsAreEmptyUponReceivingErrorResponse() {
        self.mockCharitiesService.fetchCharitiesResponse = (nil, HTTPClientError(errorType: .unknown, description: nil))

        self.sut.fetchCharities()

        XCTAssertEqual(self.sut.numberOfCharities(), 0)
    }
}

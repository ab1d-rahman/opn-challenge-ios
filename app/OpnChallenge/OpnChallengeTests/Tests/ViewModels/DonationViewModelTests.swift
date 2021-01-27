//
//  DonationViewModelTests.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 27/1/21.
//

import XCTest
@testable import OpnChallenge

class DonationViewModelTests: XCTestCase {
    var sut: DonationViewModel!
    var mockCharitiesService: MockCharitiesService!

    var didFinishMakingDonationCalled: Bool!
    var didFinishMakingDonationCalledWithErrorMessage: String?

    override func setUp() {
        super.setUp()

        self.mockCharitiesService = MockCharitiesService()
        self.sut = DonationViewModel(charitiesService: mockCharitiesService)
        self.sut.delegate = self

        self.didFinishMakingDonationCalled = false
        self.didFinishMakingDonationCalledWithErrorMessage = nil
    }

    // MARK: - Tests for isValidInput

    func testIsValidInputWhenNameAndAmountAreNil() {
        let name: String? = nil
        let amount: String? = nil

        XCTAssertFalse(self.sut.isValidInput(name: name, amount: amount))
    }

    func testIsValidInputWhenNameAndAmountAreEmpty() {
        let name = "  "
        let amount = ""

        XCTAssertFalse(self.sut.isValidInput(name: name, amount: amount))
    }

    func testIsValidInputWhenAmountStringIsNotInteger() {
        let name = "A"
        let amount = "A"

        XCTAssertFalse(self.sut.isValidInput(name: name, amount: amount))
    }

    func testIsValidInputWhenNameAndAmountAreNotEmptyAndAmountStringIsInteger() {
        let name = "  A"
        let amount = "10  "

        XCTAssertTrue(self.sut.isValidInput(name: name, amount: amount))
    }

    // MARK: - Tests for setNameAndAmount

    func testSetNameAndAmountWhenNameAndAmountAreNil() {
        let name: String? = nil
        let amount: String? = nil

        self.sut.setNameAndAmount(name: name, amount: amount)

        XCTAssertEqual(self.sut.donorName, "")
        XCTAssertEqual(self.sut.donationAmount, 0)
    }

    func testSetNameAndAmountWhenNameAndAmountAreEmpty() {
        let name = "  "
        let amount = ""

        self.sut.setNameAndAmount(name: name, amount: amount)

        XCTAssertEqual(self.sut.donorName, "")
        XCTAssertEqual(self.sut.donationAmount, 0)
    }

    func testSetNameAndAmountWhenAmountStringIsNotInteger() {
        let name = "A"
        let amount = "A"

        self.sut.setNameAndAmount(name: name, amount: amount)

        XCTAssertEqual(self.sut.donorName, "")
        XCTAssertEqual(self.sut.donationAmount, 0)
    }

    func testSetNameAndAmountWhenNameAndAmountAreNotEmptyAndAmountStringIsInteger() {
        let name = "  A"
        let amount = "10  "

        self.sut.setNameAndAmount(name: name, amount: amount)

        XCTAssertEqual(self.sut.donorName, "A")
        XCTAssertEqual(self.sut.donationAmount, 10)
    }

    // MARK: - Tests for makeDonation

    func testDelegateMethodsCalledWithErrorMessageAsNilUponReceivingSuccessResponse() {
        let successResponse = MakeDonationResponseModel(success: true)
        self.mockCharitiesService.makeDonationResponse = (successResponse, nil)

        self.sut.makeDonation()

        XCTAssertTrue(self.didFinishMakingDonationCalled)
        XCTAssertEqual(self.didFinishMakingDonationCalledWithErrorMessage, nil)
    }

    func testDelegateMethodsCalledWithErrorMessageSetUponReceivingErrorResponse() {
        let errorResponse = HTTPClientError(errorType: .noInternetConnection, description: nil)
        self.mockCharitiesService.makeDonationResponse = (nil, errorResponse)

        self.sut.makeDonation()

        XCTAssertTrue(self.didFinishMakingDonationCalled)
        XCTAssertEqual(self.didFinishMakingDonationCalledWithErrorMessage, errorResponse.errorMessage)
    }
}

extension DonationViewModelTests: DonationViewModelDelegate {
    func didStartMakingDonation() {
        return
    }

    func didFinishMakingDonation(errorMessage: String?) {
        self.didFinishMakingDonationCalled = true
        self.didFinishMakingDonationCalledWithErrorMessage = errorMessage
    }
}

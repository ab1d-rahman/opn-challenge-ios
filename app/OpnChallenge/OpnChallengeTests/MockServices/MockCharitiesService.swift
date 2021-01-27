//
//  MockCharitiesService.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 27/1/21.
//

import Foundation
@testable import OpnChallenge

class MockCharitiesService: CharitiesServiceProtocol {
    var fetchCharitiesResponse: ([Charity]?, HTTPClientError?)!

    func fetchCharities(completion: @escaping ([Charity]?, HTTPClientError?) -> Void) {
        completion(fetchCharitiesResponse.0, fetchCharitiesResponse.1)
    }

    func makeDonation(usingName name: String, usingAmountInSatang amount: Int, usingCreditCardToken token: String, completion: @escaping (MakeDonationResponseModel?, HTTPClientError?) -> Void) {
    }
}

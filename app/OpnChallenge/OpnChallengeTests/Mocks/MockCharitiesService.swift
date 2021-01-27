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
    var makeDonationResponse: (MakeDonationResponseModel?, HTTPClientError?)!

    func fetchCharities(completion: @escaping ([Charity]?, HTTPClientError?) -> Void) {
        completion(self.fetchCharitiesResponse.0, self.fetchCharitiesResponse.1)
    }

    func makeDonation(usingName name: String, usingAmountInSatang amount: Int, usingCreditCardToken token: String, completion: @escaping (MakeDonationResponseModel?, HTTPClientError?) -> Void) {
        completion(self.makeDonationResponse.0, self.makeDonationResponse.1)
    }
}

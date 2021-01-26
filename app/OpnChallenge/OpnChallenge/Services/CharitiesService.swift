//
//  CharitiesService.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

public class CharitiesService {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func fetchCharities(completion: @escaping ([Charity]?, HTTPClientError?) -> Void) {
        guard let url = URLResolver.shared.resolve(using: Constants.EndPoints.charitiesList) else {
            return
        }

        self.httpClient.getRequest(requestURL: url, responseModelType: [Charity].self) { result in
            switch result {
            case .success(let response):
                completion(response.responseObject, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    public func makeDonation(usingName name: String, usingAmount amount: Int, usingCreditCardToken token: String, completion: @escaping (MakeDonationResponseModel?, HTTPClientError?) -> Void) {
        let requestModel = MakeDonationRequestModel(name: name, token: token, amount: amount)

        guard let url = URLResolver.shared.resolve(using: Constants.EndPoints.makeDonation), let requestBodyData = try? JSONEncoder().encode(requestModel) else {
            completion(nil, HTTPClientError(errorType: .unknown, description: nil))
            return
        }

        self.httpClient.postRequest(requestURL: url, requestBodyData: requestBodyData, responseModelType: MakeDonationResponseModel.self) { result in
            switch result {
            case .success(let response):
                completion(response.responseObject, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

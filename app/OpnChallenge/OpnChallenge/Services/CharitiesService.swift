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
}

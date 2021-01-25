//
//  HTTPClient.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

public class HTTPClient {

    public func getRequest<T: Decodable>(requestURL: URL, responseModelType: T.Type, completion: @escaping (T?) -> Void) {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { (data, httpResponse, error) in
            if error == nil, let data = data {
                let resposeObject = try? JSONDecoder().decode(responseModelType, from: data)
                completion(resposeObject)
            }
        }.resume()
    }
}

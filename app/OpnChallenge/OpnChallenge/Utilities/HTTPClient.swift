//
//  HTTPClient.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

class HTTPClient {
    public typealias Success<T: Decodable> = (responseObject: T?, statusCode: Int?)

    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    public func getRequest<T: Decodable>(requestURL: URL, responseModelType: T.Type, completion: @escaping (Result<Success<T>, HTTPClientError>) -> Void) {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "GET"

        self.makeRequest(with: urlRequest, responseModelType: responseModelType, completion: completion)
    }

    public func postRequest<T: Decodable>(requestURL: URL, requestBodyData: Data, responseModelType: T.Type, completion: @escaping (Result<Success<T>, HTTPClientError>) -> Void) {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBodyData
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        self.makeRequest(with: urlRequest, responseModelType: responseModelType, completion: completion)
    }

    private func makeRequest<T: Decodable>(with urlRequest: URLRequest, responseModelType: T.Type, completion: @escaping (Result<Success<T>, HTTPClientError>) -> Void) {
        self.urlSession.dataTask(with: urlRequest) { (data, httpResponse, error) in
            let statusCode = (httpResponse as? HTTPURLResponse)?.statusCode

            if let error = error {
                let nsError = error as NSError
                if nsError.domain == NSURLErrorDomain {
                    switch nsError.code {
                    case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                        completion(.failure(HTTPClientError(errorType: .noInternetConnection, description: error.localizedDescription)))
                        return
                    case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                        completion(.failure(HTTPClientError(errorType: .serverUnreachable, description: error.localizedDescription)))
                        return
                    default:
                        break
                    }
                }

                completion(.failure(HTTPClientError(errorType: .unknown, description: error.localizedDescription)))
            } else if let data = data, data.count != 0 {
                guard let statusCode = statusCode else {
                    completion(.failure(HTTPClientError(errorType: .unknown, description: nil)))
                    return
                }

                guard 200..<300 ~= statusCode else {
                    completion(.failure(HTTPClientError(errorType: .errorResponse(statusCode), description: nil)))
                    return
                }

                if let resposeObject = try? JSONDecoder().decode(responseModelType, from: data) {
                    completion(.success((resposeObject, statusCode)))
                } else {
                    let errorDescription = "Error while parsing following JSON response: \(String(data: data, encoding: .utf8) ?? "")"
                    completion(.failure(HTTPClientError(errorType: .parsingJSON, description: errorDescription)))
                }
            }
        }.resume()
    }
}

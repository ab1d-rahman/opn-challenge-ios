//
//  URLSession+URLSessionProtocol.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 28/1/21.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol{}

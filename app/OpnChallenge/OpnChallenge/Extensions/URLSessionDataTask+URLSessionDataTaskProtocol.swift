//
//  URLSessionDataTask+URLSessionDataTaskProtocol.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 28/1/21.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol{}

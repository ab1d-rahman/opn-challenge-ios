//
//  URLResolver.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

class URLResolver {
    public static let shared = URLResolver()

    private let baseURL = "http://192.168.1.14:8080/"

    private init() {}

    public func resolve(using endpoint: String) -> URL? {
        return URL(string: self.baseURL + endpoint)
    }
}


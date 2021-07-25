//
//  Charity.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

public struct Charity: Decodable {
    let id: Int
    let name: String
    let logoURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoURL = "logo_url"
    }
}

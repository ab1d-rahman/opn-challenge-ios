//
//  MakeDonationRequestModel.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 26/1/21.
//

import Foundation

public struct MakeDonationRequestModel: Encodable {
    let name: String
    let token: String
    let amount: Int
}

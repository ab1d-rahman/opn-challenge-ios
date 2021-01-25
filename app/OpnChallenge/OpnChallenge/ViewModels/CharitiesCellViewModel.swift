//
//  CharitiesCellViewModel.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

class CharitiesCellViewModel {
    public let name: String
    public let logoURL: String

    init(model: Charity) {
        self.name = model.name
        self.logoURL = model.logoURL
    }
}

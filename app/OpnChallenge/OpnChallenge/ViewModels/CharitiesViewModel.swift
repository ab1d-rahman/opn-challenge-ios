//
//  CharitiesViewModel.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

class CharitiesViewModel {
    private let charitiesService: CharitiesService

    init(charitiesService: CharitiesService) {
        self.charitiesService = charitiesService
    }

    public func fetchCharities() {
        self.charitiesService.fetchCharities { (charities) in
            debugPrint(charities)
        }
    }
}

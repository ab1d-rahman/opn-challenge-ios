//
//  CharitiesViewModel.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

protocol CharitiesViewModelDelegate: NSObjectProtocol {
    func didFetchCharities()
}

class CharitiesViewModel {
    private let charitiesService: CharitiesService
    private var cellViewModels: [CharitiesCellViewModel]

    weak var delegate: CharitiesViewModelDelegate?

    init(charitiesService: CharitiesService) {
        self.charitiesService = charitiesService
        self.cellViewModels = [CharitiesCellViewModel]()
    }

    public func fetchCharities() {
        self.charitiesService.fetchCharities { (charities, error) in
            guard let charities = charities, error == nil else {
                debugPrint(error)
                return
            }

            self.cellViewModels = charities.map({ CharitiesCellViewModel(model: $0) })
            self.delegate?.didFetchCharities()
        }
    }

    public func numberOfCharities() -> Int {
        return self.cellViewModels.count
    }

    public func getCellViewModel(at row: Int) -> CharitiesCellViewModel {
        return self.cellViewModels[row]
    }
}

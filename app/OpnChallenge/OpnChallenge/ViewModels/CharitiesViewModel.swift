//
//  CharitiesViewModel.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

protocol CharitiesViewModelDelegate: AnyObject {
    func didStartFetchingCharities()

    func didFinishFetchingCharities(errorMessage: String?)
}

class CharitiesViewModel {
    private let charitiesService: CharitiesServiceProtocol
    private var cellViewModels: [CharitiesCellViewModel]

    weak var delegate: CharitiesViewModelDelegate?

    init(charitiesService: CharitiesServiceProtocol) {
        self.charitiesService = charitiesService
        self.cellViewModels = [CharitiesCellViewModel]()
    }

    public func fetchCharities() {
        self.delegate?.didStartFetchingCharities()

        self.charitiesService.fetchCharities { (charities, error) in
            if let error = error {
                self.delegate?.didFinishFetchingCharities(errorMessage: error.errorMessage)
                return
            }

            if let charities = charities {
                self.cellViewModels = charities.map({ CharitiesCellViewModel(model: $0) })
                self.delegate?.didFinishFetchingCharities(errorMessage: nil)
            }
        }
    }

    public func numberOfCharities() -> Int {
        return self.cellViewModels.count
    }

    public func getCellViewModel(at row: Int) -> CharitiesCellViewModel {
        return self.cellViewModels[row]
    }
}

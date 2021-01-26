//
//  DonationViewModel.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 27/1/21.
//

import Foundation

protocol DonationViewModelDelegate: NSObjectProtocol {
    func didStartMakingDonation()
    func didFinishMakingDonation(errorMessage: String?)
}

class DonationViewModel {
    private let charitiesService: CharitiesService

    weak var delegate: DonationViewModelDelegate?

    init(charitiesService: CharitiesService) {
        self.charitiesService = charitiesService
    }

    public func makeDonation(usingName name: String, usingAmount amount: Int, usingCreditCardToken token: String) {
        self.delegate?.didStartMakingDonation()

        self.charitiesService.makeDonation(usingName: name, usingAmount: amount, usingCreditCardToken: token) { (responseObject, error) in
            if let error = error {
                self.delegate?.didFinishMakingDonation(errorMessage: error.errorMessage)
                return
            }

            if let responseObject = responseObject, responseObject.success {
                self.delegate?.didFinishMakingDonation(errorMessage: nil)
            } else {
                self.delegate?.didFinishMakingDonation(errorMessage: "Something went wrong message".localized)
            }
        }
    }
}

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
    private let charitiesService: CharitiesServiceProtocol

    private(set) var donorName: String
    private(set) var donationAmount: Int
    private(set) var cardToken: String

    weak var delegate: DonationViewModelDelegate?

    init(charitiesService: CharitiesServiceProtocol) {
        self.charitiesService = charitiesService

        self.donorName = ""
        self.donationAmount = 0
        self.cardToken = ""
    }

    public func isValidInput(name: String?, amount: String?) -> Bool {
        guard let name = name, let amount = amount else {
            return false
        }

        return !name.containsOnlyWhiteSpaceOrNewLine() &&
               !amount.containsOnlyWhiteSpaceOrNewLine() &&
               Int(amount.trimmed) != nil
    }

    public func setNameAndAmount(name: String?, amount: String?) {
        guard let name = name, let amount = amount, let amountAsInt = Int(amount.trimmed) else {
            return
        }

        self.donorName = name.trimmed
        self.donationAmount = amountAsInt
    }

    public func setCardToken(token: String) {
        self.cardToken = token
    }

    public func makeDonation() {
        self.delegate?.didStartMakingDonation()

        let donationAmountInSatang = self.donationAmount * 100
        self.charitiesService.makeDonation(usingName: self.donorName, usingAmountInSatang: donationAmountInSatang, usingCreditCardToken: self.cardToken) { (responseObject, error) in
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

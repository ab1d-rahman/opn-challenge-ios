//
//  DonationViewController.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 26/1/21.
//

import UIKit
import OmiseSDK

class DonationViewController: UIViewController {
    @IBOutlet weak var charityNameLabel: UILabel!
    @IBOutlet weak var donorNameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!

    var charityName: String?

    private let viewModel = DonationViewModel(charitiesService: CharitiesService(httpClient: HTTPClient()))

    private let segueToDonationSuccessViewController = "ToDonationSuccessViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.charityNameLabel.text = self.charityName

        self.viewModel.delegate = self
    }

    @IBAction func donatePressed(_ sender: Any) {
        self.view.endEditing(true)

        self.showCreditCardFormView()
    }

    private func showCreditCardFormView() {
        let creditCardView = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: Constants.Keys.omisePublicKey)
        creditCardView.delegate = self

        let navController = UINavigationController(rootViewController: creditCardView)
        self.present(navController, animated: true, completion: nil)
    }
}

extension DonationViewController: CreditCardFormViewControllerDelegate {
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
        controller.dismiss(animated: true) { [unowned self] in
            self.viewModel.makeDonation(usingName: self.donorNameTextField.text!, usingAmount: Int(self.amountTextField.text!)!, usingCreditCardToken: token.id)
        }
    }

    func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
        print(error)
    }

    func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension DonationViewController: DonationViewModelDelegate {
    func didFinishMakingDonation(errorMessage: String?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            if let errorMessage = errorMessage {
                let alert = UIAlertController.makeAlert(title: "Error".localized, message: errorMessage)
                self.present(alert, animated: true, completion: nil)

                return
            }

            self.performSegue(withIdentifier: self.segueToDonationSuccessViewController, sender: nil)
        }
    }
}

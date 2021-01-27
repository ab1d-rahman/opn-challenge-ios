//
//  DonationViewController.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 26/1/21.
//

import UIKit
import OmiseSDK
import SVProgressHUD

class DonationViewController: UIViewController {
    @IBOutlet weak var charityNameLabel: UILabel!

    @IBOutlet weak var donorNameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!

    @IBOutlet weak var donateButton: UIButton!

    var charityName: String?

    private let viewModel = DonationViewModel(charitiesService: CharitiesService(httpClient: HTTPClient()))

    private let segueToDonationSuccessViewController = "ToDonationSuccessViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupInputValidation()

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

    private func setupInputValidation() {
        self.updateDonateButtonAppearance(isEnabled: false)

        self.donorNameTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        self.amountTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }

    @objc private func textFieldsDidChange() {
        let isValidInput = self.viewModel.isValidInput(name: self.donorNameTextField.text,
                                                       amount: self.amountTextField.text)
        if isValidInput {
            self.viewModel.setNameAndAmount(name: self.donorNameTextField.text,
                                            amount: self.amountTextField.text)
        }

        self.updateDonateButtonAppearance(isEnabled: isValidInput)

    }

    private func updateDonateButtonAppearance(isEnabled: Bool) {
        self.donateButton.isEnabled = isEnabled
        self.donateButton.alpha = isEnabled ? 1.0 : 0.4
    }
}

extension DonationViewController: CreditCardFormViewControllerDelegate {
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
        self.viewModel.setCardToken(token: token.id)

        controller.dismiss(animated: true) { [unowned self] in
            self.viewModel.makeDonation()
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
    func didStartMakingDonation() {
        SVProgressHUD.show()
    }

    func didFinishMakingDonation(errorMessage: String?) {
        DispatchQueue.main.async { [weak self] in
            SVProgressHUD.dismiss()

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

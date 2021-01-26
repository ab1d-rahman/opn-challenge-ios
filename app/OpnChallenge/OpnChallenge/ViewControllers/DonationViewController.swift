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

    var charityName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.charityNameLabel.text = self.charityName
    }

    @IBAction func donatePressed(_ sender: Any) {
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
        print(token)
    }

    func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
        print(error)
    }

    func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//
//  DonationSuccessViewController.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 27/1/21.
//

import UIKit

class DonationSuccessViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func goHomePressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//
//  CharitiesViewController.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import UIKit

class CharitiesViewController: UIViewController {
    private let viewModel = CharitiesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.fetchCharities()
    }
}

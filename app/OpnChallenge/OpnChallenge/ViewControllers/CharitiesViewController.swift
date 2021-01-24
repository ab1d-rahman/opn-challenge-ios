//
//  CharitiesViewController.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import UIKit

class CharitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let viewModel = CharitiesViewModel(charitiesService: CharitiesService(httpClient: HTTPClient()))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()

        self.viewModel.delegate = self
        self.viewModel.fetchCharities()
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.tableFooterView = UIView()
    }
}

extension CharitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCharities()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharitiesTableViewCell.reuseIdentifier, for: indexPath) as? CharitiesTableViewCell else {
            return UITableViewCell()
        }

        cell.customize(using: self.viewModel.getCellViewModel(at: indexPath.row))

        return cell
    }
}

extension CharitiesViewController: CharitiesViewModelDelegate {
    func didFetchCharities() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

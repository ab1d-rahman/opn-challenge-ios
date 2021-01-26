//
//  CharitiesViewController.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import UIKit
import SVProgressHUD

class CharitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!

    private let segueToDonationViewController = "ToDonationViewController"
    
    private let viewModel = CharitiesViewModel(charitiesService: CharitiesService(httpClient: HTTPClient()))

    private var selectedRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()

        self.errorMessageLabel.isHidden = true

        self.viewModel.delegate = self
        self.viewModel.fetchCharities()
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.tableFooterView = UIView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let donationViewController = segue.destination as? DonationViewController,
           let selectedRow = self.selectedRow {
            let selectedCharityName = self.viewModel.getCellViewModel(at: selectedRow).name
            donationViewController.charityName = selectedCharityName
        }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: self.segueToDonationViewController, sender: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CharitiesViewController: CharitiesViewModelDelegate {
    func didStartFetchingCharities() {
        SVProgressHUD.show()
    }

    func didFinishFetchingCharities(errorMessage: String?) {
        DispatchQueue.main.async { [weak self] in
            SVProgressHUD.dismiss()

            if let erroMessage = errorMessage {
                self?.errorMessageLabel.text = erroMessage
                self?.errorMessageLabel.isHidden = false

                return
            }

            self?.tableView.reloadData()
        }
    }
}

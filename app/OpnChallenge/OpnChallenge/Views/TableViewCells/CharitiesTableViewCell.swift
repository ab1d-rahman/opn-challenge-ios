//
//  CharitiesTableViewCell.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import UIKit

class CharitiesTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "CharitiesTableViewCell"

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func customize(using viewModel: CharitiesCellViewModel) {
        self.nameLabel.text = viewModel.name
    }
}

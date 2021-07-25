//
//  CharitiesTableViewCell.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import UIKit
import Kingfisher

class CharitiesTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "CharitiesTableViewCell"

    @IBOutlet weak var logoImageView: AnimatedImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func customize(using viewModel: CharitiesCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.logoImageView.kf.setImage(with: URL(string: viewModel.logoURL),
                                       placeholder: UIImage(named: Constants.NamedAssets.charityLogoPlaceholder))
    }
}

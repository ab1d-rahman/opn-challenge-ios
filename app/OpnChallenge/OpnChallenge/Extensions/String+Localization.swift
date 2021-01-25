//
//  String+Localization.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 25/1/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

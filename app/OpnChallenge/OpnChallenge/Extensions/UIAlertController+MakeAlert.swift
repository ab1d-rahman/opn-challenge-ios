//
//  UIAlertController+MakeAlert.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 27/1/21.
//

import UIKit

extension UIAlertController {
    static func makeAlert(title: String? = nil,
                                message: String? = nil,
                                buttonTitle: String = "OK".localized,
                                buttonActionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: buttonActionHandler)
        alert.addAction(okAction)

        return alert
    }
}

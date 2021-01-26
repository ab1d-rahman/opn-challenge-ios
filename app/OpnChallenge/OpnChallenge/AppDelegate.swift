//
//  AppDelegate.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import UIKit
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.setupSVProgressHUD()

        return true
    }

    private func setupSVProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.clear)
    }
}


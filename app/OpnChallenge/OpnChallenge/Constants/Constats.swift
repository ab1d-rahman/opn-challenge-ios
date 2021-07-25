//
//  Constats.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 24/1/21.
//

import Foundation

public struct Constants {

    public struct EndPoints {
        static let charitiesList = "charities"
        static let makeDonation = "donations"
    }

    public struct NamedAssets {
        static let charityLogoPlaceholder = "charity-logo-placeholder"
    }

    public struct Keys {
        static let omisePublicKey = "pkey_test_5mm2u7jwdup648coz7n"
    }

    public struct HTTPStatusCodes {
        static let ok = 200
        static let badRequest = 400
        static let serverError = 500
    }
}

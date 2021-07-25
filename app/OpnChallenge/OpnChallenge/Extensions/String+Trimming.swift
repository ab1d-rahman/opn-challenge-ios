//
//  String+Trimming.swift
//  OpnChallenge
//
//  Created by Abid Rahman on 27/1/21.
//

import Foundation
import UIKit

extension String {
    var trimmed: Self {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func containsOnlyWhiteSpaceOrNewLine() -> Bool {
        return self.trimmed.isEmpty
    }
}

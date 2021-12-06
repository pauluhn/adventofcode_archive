//
//  Extensions.swift
//  aocTests
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

extension String {
    func newlineSplit() -> [String] {
        return components(separatedBy: .newlines)
    }
    func commaSplit() -> [String] {
        return split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}

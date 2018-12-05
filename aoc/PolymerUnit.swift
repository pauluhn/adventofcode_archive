//
//  PolymerUnit.swift
//  aoc
//
//  Created by Paul Uhn on 12/5/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct PolymerUnit {
    let type: String
    let polarity: Polarity
    var isDead = false
    
    init(_ data: Character) {
        type = String(data).lowercased()
        polarity = String(data) == String(data).uppercased() ? .positive : .negative
    }
    
    func reacts(to other: PolymerUnit) -> Bool {
        guard type == other.type else { return false }
        return polarity != other.polarity
    }
}
extension PolymerUnit: CustomStringConvertible {
    var description: String {
        switch polarity {
        case .positive:
            return type.uppercased()
        case .negative:
            return type
        }
    }
}

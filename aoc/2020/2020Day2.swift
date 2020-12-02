//
//  2020Day2.swift
//  aoc
//
//  Created by Paul U on 12/2/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day2 {
    
    struct PasswordPolicy {
        let min: Int
        let max: Int
        let char: Character
        let password: String
        var isValid: Bool {
            let count = password
                .filter { $0 == char }
                .count
            return count >= min && count <= max
        }
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([0-9]+)-([0-9]+) ([a-z]+): ([a-z]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            min = data.match(match, at: 1).int
            max = data.match(match, at: 2).int
            char = data.match(match, at: 3).char
            password = data.match(match, at: 4)
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        return data
            .compactMap(PasswordPolicy.init)
            .filter { $0.isValid }
            .count
    }
}

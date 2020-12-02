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
        let first: Int
        let second: Int
        let char: Character
        let password: String
        
        var isValidPart1: Bool {
            let count = password
                .filter { $0 == char }
                .count
            let min = first
            let max = second
            return count >= min && count <= max
        }
        var isValidPart2: Bool {
            var a = false
            var b = false
            for (i, c) in password.enumerated() {
                if i + 1 == first && c == char {
                    a = true
                } else if i + 1 == second {
                    b = c == char
                    break
                }
            }
            switch (a, b) {
            case (true, false),
                 (false, true): return true
            default: return false
            }
        }

        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([0-9]+)-([0-9]+) ([a-z]+): ([a-z]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            first = data.match(match, at: 1).int
            second = data.match(match, at: 2).int
            char = data.match(match, at: 3).char
            password = data.match(match, at: 4)
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        return data
            .compactMap(PasswordPolicy.init)
            .filter { $0.isValidPart1 }
            .count
    }

    static func Part2(_ data: [String]) -> Int {
        return data
            .compactMap(PasswordPolicy.init)
            .filter { $0.isValidPart2 }
            .count
    }
}

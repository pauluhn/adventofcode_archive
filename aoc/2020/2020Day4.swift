//
//  2020Day4.swift
//  aoc
//
//  Created by Paul U on 12/4/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day4 {
    
    struct Passport {
        enum DataType: String {
            case birthYear  = "byr"
            case issueYear  = "iyr"
            case expireYear = "eyr"
            case height     = "hgt"
            case hairColor  = "hcl"
            case eyeColor   = "ecl"
            case passportID = "pid"
            case countryID  = "cid"
        }
        let data: [DataType: String]
        var isValid: Bool {
            return data.keys
                .filter { $0 != .countryID } // optional
                .count == 7
        }
        
        init(_ data: [String]) {
            self.data = data
                .flatMap { $0.split(separator: " ") }
                .map { $0.split(separator: ":").map(String.init) }
                .map { (DataType(rawValue: $0.first!)!, $0.last!) }
                .reduce(into: [:], { $0[$1.0] = $1.1 })
        }
    }

    static func Part1(_ data: [String]) -> Int {
        var passports = [Passport]()
        
        var cache = [String]()
        for line in data {
            if line.isEmpty && !cache.isEmpty {
                passports += [Passport(cache)]
                cache = []
            } else {
                cache += [line]
            }
        }

        return passports
            .filter { $0.isValid }
            .count
    }

}

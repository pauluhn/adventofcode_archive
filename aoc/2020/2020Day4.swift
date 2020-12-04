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
        enum Field: String {
            case birthYear  = "byr"
            case issueYear  = "iyr"
            case expireYear = "eyr"
            case height     = "hgt"
            case hairColor  = "hcl"
            case eyeColor   = "ecl"
            case passportID = "pid"
            case countryID  = "cid"
        }
        private let data: [Field: String]
        var hasRequiredFields: Bool {
            return data.keys
                .filter { $0 != .countryID } // optional
                .count == 7
        }
        var isValid: Bool {
            return data.keys
                .filter { $0 != .countryID } // optional
                .filter { isValidData(for: $0) }
                .count == 7
        }
        
        init(_ data: [String]) {
            self.data = data
                .flatMap { $0.split(separator: " ") }
                .map { $0.split(separator: ":").map(String.init) }
                .map { (Field(rawValue: $0.first!)!, $0.last!) }
                .reduce(into: [:], { $0[$1.0] = $1.1 })
        }
        private func isValidData(for field: Field) -> Bool {
            switch field {
            case .birthYear: return isValidRange(data[.birthYear], min: 1920, max: 2002)
            case .issueYear: return isValidRange(data[.issueYear], min: 2010, max: 2020)
            case .expireYear: return isValidRange(data[.expireYear], min: 2020, max: 2030)
            case .height: return isValidHeight(data[.height])
            case .hairColor: return isValidHair(data[.hairColor])
            case .eyeColor: return isValidEye(data[.eyeColor])
            case .passportID: return isValidIdentifier(data[.passportID])
            case .countryID: return true
            }
        }
        private func isValidRange(_ value: String?, min: Int, max: Int) -> Bool {
            guard let value = value?.int else { return false }
            return value >= min && value <= max
        }
        private func isValidHeight(_ height: String?) -> Bool {
            guard let height = height else { return false }
            let regex = try! NSRegularExpression(pattern: "^([0-9]+)(cm|in)$")
            guard let match = regex.firstMatch(in: height, options: [], range: NSRange(location: 0, length: height.count)) else { return false }
            switch height.match(match, at: 2) {
            case "cm": return isValidRange(height.match(match, at: 1), min: 150, max: 193)
            case "in": return isValidRange(height.match(match, at: 1), min: 59, max: 76)
            default: return false
            }
        }
        private func isValidHair(_ color: String?) -> Bool {
            guard let color = color else { return false }
            let regex = try! NSRegularExpression(pattern: "^#([0-9a-f]{6})$")
            guard let _ = regex.firstMatch(in: color, options: [], range: NSRange(location: 0, length: color.count)) else { return false }
            return true
        }
        private func isValidEye(_ color: String?) -> Bool {
            guard let color = color else { return false }
            let colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
            return colors.contains(color)
        }
        private func isValidIdentifier(_ id: String?) -> Bool {
            guard let id = id else { return false }
            let regex = try! NSRegularExpression(pattern: "^([0-9]{9})$")
            guard let _ = regex.firstMatch(in: id, options: [], range: NSRange(location: 0, length: id.count)) else { return false }
            return true
        }
    }

    private static func passports(_ data: [String]) -> [Passport] {
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
    }
    
    static func Part1(_ data: [String]) -> Int {
        return passports(data)
            .filter { $0.hasRequiredFields }
            .count
    }

    static func Part2(_ data: [String]) -> Int {
        return passports(data)
            .filter { $0.isValid }
            .count
    }
}

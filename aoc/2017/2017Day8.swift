//
//  2017Day8.swift
//  aoc
//
//  Created by Paul Uhn on 11/4/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day8 {

    struct Instruction: CustomStringConvertible {
        enum Compare: String {
            case lessThan = "<"
            case greaterThan = ">"
            case lessThanOrEqual = "<="
            case greaterThanOrEqual = ">="
            case equal = "=="
            case notEqual = "!="
        }
        let register1: String
        let increment: Bool
        let amount: Int
        let register2: String
        let compare: Compare
        let compareValue: Int

        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([a-z]+) (inc|dec) (-?\\d+) if ([a-z]+) ([<>=!]+) (-?\\d+)")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            
            register1 = data.match(match, at: 1)
            increment = data.match(match, at: 2) == "inc"
            amount = data.match(match, at: 3).int
            register2 = data.match(match, at: 4)
            compare = Compare(rawValue: data.match(match, at: 5))!
            compareValue = data.match(match, at: 6).int
        }
        var description: String {
            return "\(register1) \(increment ? "inc" : "dec") \(amount) if \(register2) \(compare.rawValue) \(compareValue)"
        }
        func compareResult(_ register2Value: Int) -> Bool {
            switch compare {
            case .lessThan: return register2Value < compareValue
            case .greaterThan: return register2Value > compareValue
            case .lessThanOrEqual: return register2Value <= compareValue
            case .greaterThanOrEqual: return register2Value >= compareValue
            case .equal: return register2Value == compareValue
            case .notEqual: return register2Value != compareValue
            }
        }
    }
    
    struct Cache {
        private var cache: [String: Int] = [:]
        mutating func get(_ key: String) -> Int {
            guard let value = cache[key] else {
                cache[key] = 0
                return 0
            }
            return value
        }
        mutating func set(_ key: String, _ value: Int) {
            cache[key] = value
        }
        var result: Int {
            return cache.values.sorted().last ?? 0
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        let instructions = data.compactMap(Instruction.init)
        var cache = Cache()
        
        for instruction in instructions {
            let register2Value = cache.get(instruction.register2)
            if instruction.compareResult(register2Value) {
                var register1Value = cache.get(instruction.register1)
                if instruction.increment {
                    register1Value += instruction.amount
                } else {
                    register1Value -= instruction.amount
                }
                cache.set(instruction.register1, register1Value)
            }
        }
        return cache.result
    }
}


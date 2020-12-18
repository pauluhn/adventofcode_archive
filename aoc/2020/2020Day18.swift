//
//  2020Day18.swift
//  aoc
//
//  Created by Paul U on 12/18/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day18 {
    
    enum Operator: Character {
        case add = "+"
        case multiply = "*"
        case open = "("
        case close = ")"
    }

    static func Part1(_ data: [String]) -> Int {
        var sum = 0
        for data in data where !data.isEmpty {
            var d = data.replacingOccurrences(of: " ", with: "")
            let answer = parse(&d)
            guard d.isEmpty else { fatalError() }
            sum += answer
        }
        return sum
    }
    
    private static func parse(_ data: inout String) -> Int {
        var value: Int?
        var op: Operator?
        while true {
            let c = data.removeFirst()
            switch Operator(rawValue: c) {
            case .add: op = .add
            case .multiply: op = .multiply
            case .open: value = compute(value, op, parse(&data).str)
            case .close: return value ?? 0
            default: value = compute(value, op, c.str)
            }
            if data.isEmpty { break }
        }
        return value ?? 0
    }
    
    private static func compute(_ value: Int?, _ op: Operator?, _ c: String) -> Int {
        if value == nil {
            return c.int
        } else if op != nil {
            switch op {
            case .add: return value! + c.int
            case .multiply: return value! * c.int
            default: fatalError()
            }
        }
        fatalError()
    }
}

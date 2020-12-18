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
    
    enum Math {
        case add
        case multiply
        case value(Int)
    }

    static func Part1(_ data: [String]) -> Int {
        var sum = 0
        for data in data where !data.isEmpty {
            var d = data.replacingOccurrences(of: " ", with: "")
            let answer = parse1(&d)
            guard d.isEmpty else { fatalError() }
            sum += answer
        }
        return sum
    }
    
    static func Part2(_ data: [String]) -> Int {
        var sum = 0
        for data in data where !data.isEmpty {
            var d = data.replacingOccurrences(of: " ", with: "")
            let answer = parse2(&d)
            guard d.isEmpty else { fatalError() }
            sum += answer
        }
        return sum
    }
    
    private static func parse1(_ data: inout String) -> Int {
        var value: Int?
        var op: Operator?
        while true {
            let c = data.removeFirst()
            switch Operator(rawValue: c) {
            case .add: op = .add
            case .multiply: op = .multiply
            case .open: value = compute(value, op, parse1(&data).str)
            case .close: return value ?? 0
            default: value = compute(value, op, c.str)
            }
            if data.isEmpty { break }
        }
        return value ?? 0
    }
    
    private static func parse2(_ data: inout String) -> Int {
        var math = [Math]()
        var isParsing = true
        while isParsing {
            let c = data.removeFirst()
            switch Operator(rawValue: c) {
            case .add: math += [.add]
            case .multiply: math += [.multiply]
            case .open: math += [.value(parse2(&data))]
            case .close: isParsing = false
            default: math += [.value(c.int)]
            }
            if !isParsing || data.isEmpty { break }
        }
        // add
        var summed = [Math]()
        var value: Int?
        var op: Operator?
        for m in math {
            switch m {
            case .add:
                op = .add
                
            case .multiply:
                summed += [.value(value!), .multiply]
                value = nil
                op = nil
                
            case .value(let v):
                if value == nil {
                    value = v
                } else if op != nil {
                    switch op {
                    case .add: value = value! + v
                    case .multiply: fatalError()
                    default: fatalError()
                    }
                }
            }
        }
        if value != nil {
            summed += [.value(value!)]
        }
        value = nil
        op = nil
        // multiply
        for m in summed {
            switch m {
            case .add: fatalError()
            case .multiply: op = .multiply
                
            case .value(let v):
                if value == nil {
                    value = v
                } else if op != nil {
                    switch op {
                    case .add: fatalError()
                    case .multiply: value = value! * v
                    default: fatalError()
                    }
                }
            }
        }
        return value!
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

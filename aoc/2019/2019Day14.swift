//
//  2019Day14.swift
//  aoc
//
//  Created by Paul Uhn on 12/22/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day14 {
    
    struct Chemical: Hashable {
        let name: String
        static let ORE = Chemical(name: "ORE")
        static let FUEL = Chemical(name: "FUEL")
        
        init(name: Substring) { self.name = String(name) }
    }
    
    struct Reaction {
        var inputs: [Chemical: Int]
        let output: Chemical
        let amount: Int
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([0-9 A-Z,]+) => ([0-9 A-Z]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            
            let kv = data.match(match, at: 1)
                .commaSplit()
                .map { Reaction.tuple($0) }
            inputs = Dictionary(uniqueKeysWithValues: kv)
            
            (output, amount) = Reaction.tuple(
                data.match(match, at: 2))
        }
        
        private static func tuple(_ data: String) -> (Chemical, Int) {
            let input = data.split(separator: " ")
            return (Chemical(name: input.last!), input.first!.int)
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        let reactions = data.compactMap(Reaction.init)
        return nanofactory(reactions, 1)
    }
    
    static func Part2(_ data: [String]) -> Int {
        let ORE = 1000000000000
        let reactions = data.compactMap(Reaction.init)

        var min = 1
        var max = ORE
        while true {
            let middle = (max + min) / 2
            if middle == min {
                return middle
            }
            
            let ore = nanofactory(reactions, middle)
            if ore < ORE {
                min = middle
            } else {
                max = middle
            }
        }
    }
    
    private static func nanofactory(_ reactions: [Reaction], _ fuelAmount: Int) -> Int {
        var fuel = reactions.first { $0.output == .FUEL }!
        fuel.inputs[.FUEL] = fuelAmount - 1
        var updated = false
        
        repeat {
            updated = false
            
            for input in fuel.inputs where input.key != .ORE {
                let reaction = reactions.first { $0.output == input.key }!
                let amount = fuel.inputs[input.key]!
                guard amount > 0 else { continue }

                replace(&fuel, reaction, multiply(reaction.amount, amount))
                updated = true
            }
        } while updated
        
        return fuel.inputs[.ORE]!
    }
    
    private static func replace(_ fuel: inout Reaction, _ reaction: Reaction, _ multiples: Int) {
        for input in reaction.inputs {
            var amount = input.value * multiples
            if let existing = fuel.inputs[input.key] {
                amount += existing
            }
            fuel.inputs[input.key] = amount
        }
        fuel.inputs[reaction.output] = fuel.inputs[reaction.output]! - reaction.amount * multiples
    }
    
    private static func multiply(_ input: Int, _ output: Int) -> Int {
        var multiples = output / input
        if output % input != 0 {
            multiples += 1
        }
        return multiples
    }
}

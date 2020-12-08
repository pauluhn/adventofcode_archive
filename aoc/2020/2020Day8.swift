//
//  2020Day8.swift
//  aoc
//
//  Created by Paul U on 12/8/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day8 {
    
    struct Instruction {
        enum Operation: String {
            case accumulator = "acc"
            case jumps = "jmp"
            case noOperation = "nop"
        }
        let operation: Operation
        let value: Int
        
        init?(_ data: String) {
            let data = data.split(separator: " ")
            guard data.count == 2,
                  let op = Operation(rawValue: data[0].str) else { return nil }
            operation = op
            value = data[1].int
        }
    }

    static func Part1(_ data: [String]) -> Int {
        let instructions = data.map(Instruction.init)
        
        var index = 0
        var value = 0
        var seen = Set<Int>()
        
        while true {
            guard !seen.contains(index) else { break }
            seen.insert(index)
            
            let line = instructions[index]!
            switch line.operation {
            case .accumulator: value += line.value
            case .jumps: index += line.value; continue
            case .noOperation: break
            }
            index += 1
        }
        return value
    }
}

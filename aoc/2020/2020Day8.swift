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
            
            var flipped: Operation {
                switch self {
                case .accumulator: return .accumulator
                case .jumps: return .noOperation
                case .noOperation: return .jumps
                }
            }
        }
        let operation: Operation
        let value: Int
        var isFlippable: Bool {
            return operation != operation.flipped
        }
        var flipped: Instruction {
            return Instruction(operation.flipped, value)
        }
        
        init?(_ data: String) {
            let data = data.split(separator: " ")
            guard data.count == 2,
                  let op = Operation(rawValue: data[0].str) else { return nil }
            operation = op
            value = data[1].int
        }
        private init(_ operation: Operation, _ value: Int) {
            self.operation = operation
            self.value = value
        }
    }

    static func Part1(_ data: [String]) -> Int {
        let instructions = data.compactMap(Instruction.init)
        return run(instructions).0
    }
    
    static func Part2(_ data: [String]) -> Int {
        let instructions = data.compactMap(Instruction.init)
        for (index, instruction) in instructions.enumerated() where instruction.isFlippable {
            var newList = instructions
            newList[index] = instruction.flipped
            let results = run(newList)
            if !results.1 {
                return results.0
            }
        }
        return 0
    }
    
    private static func run(_ instructions: [Instruction]) -> (Int, Bool) {
        var index = 0
        var value = 0
        var seen = Set<Int>()
        var isInfiniteLoop = false
        
        while true {
            guard index < instructions.count else { break }
            guard !seen.contains(index) else { isInfiniteLoop = true; break }
            seen.insert(index)
            
            let line = instructions[index]
            switch line.operation {
            case .accumulator: value += line.value
            case .jumps: index += line.value; continue
            case .noOperation: break
            }
            index += 1
        }
        return (value, isInfiniteLoop)
    }
}

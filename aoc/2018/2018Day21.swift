//
//  2018Day21.swift
//  aoc
//
//  Created by Paul Uhn on 12/21/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day21 {
    static func Part1(_ data: [String], _ zero: OpCode.Value) -> Int {
        let program = OpCodeProgram(data)
        let ip = program.ip
        var registers: [OpCode.Value] = Array(repeating: 0, count: 6)
        registers[0] = zero

        // change register count
        let registerCount = OpCode.registerCount
        OpCode.registerCount = 6
        
        let countedSet = NSCountedSet()
        
        while registers[ip] < program.lines.count {
            let line = program.lines[registers[ip]]
            let saved = registers
            Y2018Day19.runOpCode(&registers, line.opCode, line.values)
//            print("\(saved) -> \(line.opCode.rawValue) \(line.values) -> \(registers) -> \(registers[ip] + 1)")
            if registers[4] == 28 {
                let key = registers[3]
                countedSet.add(key)
                let count = countedSet.count(for: key)
                if count > 1 {
                    print("\(registers[4]) -> \(key) (\(count)) - previous \(saved[3])")
                }
            }
            registers[ip] += 1
        }
        
        // reset register count
        OpCode.registerCount = registerCount
        
        return zero
    }
}

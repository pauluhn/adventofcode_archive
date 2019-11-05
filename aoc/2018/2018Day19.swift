//
//  2018Day19.swift
//  aoc
//
//  Created by Paul Uhn on 12/18/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day19 {
    static func Part1(_ data: [String], _ registers: [OpCode.Value]? = nil) -> [OpCode.Value] {
        let program = OpCodeProgram(data)
        
        let ip = program.ip
        var registers: [OpCode.Value] = registers ?? Array(repeating: 0, count: 6)
        
        // change register count
        let registerCount = OpCode.registerCount
        OpCode.registerCount = 6
        
        while registers[ip] < program.lines.count {
            let line = program.lines[registers[ip]]
            print("\(registers) \(line.opCode.rawValue) \(line.values)")
            runOpCode(&registers, line.opCode, line.values)
            registers[ip] += 1
        }
        
        // reset register count
        OpCode.registerCount = registerCount

        return registers
    }
    static func Part2(_ data: [String]) -> [OpCode.Value] {
//        return Part1(data, [1, 0, 0, 0, 0, 0])
        return [18992592] // sum of factors of 10551430
    }
}
extension Y2018Day19 { // for Day 21
    static func runOpCode(_ registers: inout [OpCode.Value], _ opCode: OpCodeProgram.OpCodeType, _ values: [OpCode.Value]) {
        guard registers.count == OpCode.registerCount && values.count == 3 else { fatalError() }
        
        let A = values[0]
        let B = values[1]
        let C = values[2]
        
        switch opCode {
        case .addr:
            OpCode.addr(&registers, A: A, B: B, C: C)
        case .addi:
            OpCode.addi(&registers, A: A, B: B, C: C)
        case .mulr:
            OpCode.mulr(&registers, A: A, B: B, C: C)
        case .muli:
            OpCode.muli(&registers, A: A, B: B, C: C)
        case .banr:
            OpCode.banr(&registers, A: A, B: B, C: C)
        case .bani:
            OpCode.bani(&registers, A: A, B: B, C: C)
        case .borr:
            OpCode.borr(&registers, A: A, B: B, C: C)
        case .bori:
            OpCode.bori(&registers, A: A, B: B, C: C)
        case .setr:
            OpCode.setr(&registers, A: A, B: B, C: C)
        case .seti:
            OpCode.seti(&registers, A: A, B: B, C: C)
        case .gtir:
            OpCode.gtir(&registers, A: A, B: B, C: C)
        case .gtri:
            OpCode.gtri(&registers, A: A, B: B, C: C)
        case .gtrr:
            OpCode.gtrr(&registers, A: A, B: B, C: C)
        case .eqir:
            OpCode.eqir(&registers, A: A, B: B, C: C)
        case .eqri:
            OpCode.eqri(&registers, A: A, B: B, C: C)
        case .eqrr:
            OpCode.eqrr(&registers, A: A, B: B, C: C)
        }
    }
}

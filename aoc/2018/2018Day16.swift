//
//  2018Day16.swift
//  aoc
//
//  Created by Paul Uhn on 12/16/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day16 {
    enum Stage {
        case before
        case instruction
        case after
    }
    enum OpCodeType: CaseIterable {
        case addr
        case addi
        case mulr
        case muli
        case banr
        case bani
        case borr
        case bori
        case setr
        case seti
        case gtir
        case gtri
        case gtrr
        case eqir
        case eqri
        case eqrr
    }
    static func Part1(_ data: [String], _ matching: Int) -> (count: Int, table: [OpCode.Value: OpCodeType]) {
        let instructions = data.compactMap(OpCodeInstruction.init)
        
        var registers = [OpCode.Value]()
        var operation = [OpCode.Value]()
        var stage: Stage = .before
        var runningTotal = 0
        
        var opCodeTable = [OpCode.Value: Set<OpCodeType>]()
        
        for instruction in instructions {
            switch instruction.type {
            case .before(let values) where stage == .before:
                registers = values
                stage = .instruction
            case .instruction(let values) where stage == .instruction:
                guard !values.isEmpty else { fatalError() }
                operation = values
                stage = .after
            case .after(let values) where stage == .after:
                let opCodeTypes = matchOpCodes(registers, operation, values)
                
                var set = opCodeTable[operation[0], default: Set<OpCodeType>()]
                for type in opCodeTypes {
                    set.insert(type)
                }
                opCodeTable[operation[0]] = set
                
                let count = opCodeTypes.count
                if count >= matching {
                    runningTotal += 1
                }
                stage = .before
            default: break
            }
        }
        return (runningTotal, computeOpCodes(opCodeTable))
    }
    static func Part2(_ data1: [String], _ data2: [String], _ register: Int) -> Int {
        let table = Part1(data1, 3).table
        let instructions = data2.compactMap(OpCodeInstruction.init)

        var registers = Array(repeating: OpCode.initialRegisterValue, count: 4)
        
        for instruction in instructions {
            switch instruction.type {
            case .instruction(let values):
                runOpCode(&registers, values, table)
            default: break
            }
        }
        return registers[register]
    }
}
private extension Y2018Day16 {
    static func matchOpCodes(_ registers: [OpCode.Value], _ instruction: [OpCode.Value], _ results: [OpCode.Value]) -> [OpCodeType] {
        guard registers.count == OpCode.registerCount &&
            instruction.count == OpCode.registerCount &&
            results.count == OpCode.registerCount else { fatalError() }
        var matching = [OpCodeType]()
        
        for opCode in OpCodeType.allCases {
            var copy = registers
            let A = instruction[1]
            let B = instruction[2]
            let C = instruction[3]

            switch opCode {
            case .addr:
                OpCode.addr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.addr) }
            case .addi:
                OpCode.addi(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.addi) }
            case .mulr:
                OpCode.mulr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.mulr) }
            case .muli:
                OpCode.muli(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.muli) }
            case .banr:
                OpCode.banr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.banr) }
            case .bani:
                OpCode.bani(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.bani) }
            case .borr:
                OpCode.borr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.borr) }
            case .bori:
                OpCode.bori(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.bori) }
            case .setr:
                OpCode.setr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.setr) }
            case .seti:
                OpCode.seti(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.seti) }
            case .gtir:
                OpCode.gtir(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.gtir) }
            case .gtri:
                OpCode.gtri(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.gtri) }
            case .gtrr:
                OpCode.gtrr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.gtrr) }
            case .eqir:
                OpCode.eqir(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.eqir) }
            case .eqri:
                OpCode.eqri(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.eqri) }
            case .eqrr:
                OpCode.eqrr(&copy, A: A, B: B, C: C)
                if copy == results { matching.append(.eqrr) }
            }
        }
        return matching
    }
    static func computeOpCodes(_ opCodeTable: [OpCode.Value: Set<OpCodeType>]) -> [OpCode.Value: OpCodeType] {
        var opCodeTable = opCodeTable
        var finalTable = [OpCode.Value: OpCodeType]()
        
        let count = opCodeTable.count
        while finalTable.count < count {
            guard let oneOpCode = opCodeTable.first(where: { $0.1.count == 1 }) else { return finalTable }
            let value = oneOpCode.value.first!
            finalTable[oneOpCode.key] = value
            
            opCodeTable[oneOpCode.key] = nil
            for (k, v) in opCodeTable where v.contains(value) {
                var v = v
                v.remove(value)
                opCodeTable[k] = v
            }
        }
        return finalTable
    }
    static func runOpCode(_ registers: inout [OpCode.Value], _ instruction: [OpCode.Value], _ table: [OpCode.Value: OpCodeType]) {
        guard registers.count == OpCode.registerCount && instruction.count == OpCode.registerCount else { fatalError() }
        
        let opCode = table[instruction[0]]!
        let A = instruction[1]
        let B = instruction[2]
        let C = instruction[3]
        
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

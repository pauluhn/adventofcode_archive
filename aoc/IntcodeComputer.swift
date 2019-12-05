//
//  IntcodeComputer.swift
//  aoc
//
//  Created by Paul Uhn on 12/5/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

class IntcodeComputer {
    private var program: [Int]
    private var pointer = 0
    
    enum Opcode {
        case add
        case multiply
        case done
    }
    
    enum StepResult {
        case success
        case failure
        case done
    }
    
    init(program: [Int]) {
        self.program = program
    }
    
    func run() -> [Int] {
        while true {
            switch step() {
            case .success: break
            case .failure: return []
            case .done: return program
            }
        }
    }
}

private extension IntcodeComputer {
    var opcode: Opcode {
        switch program[pointer] {
        case 1: return .add
        case 2: return .multiply
        case 99: return .done
        default: fatalError()
        }
    }
    
    var inbounds: Bool {
        let first = program[pointer + 1]
        let second = program[pointer + 2]
        let third = program[pointer + 3]
        return first < program.count
            && second < program.count
            && third < program.count
    }

    func step() -> StepResult {
        switch opcode {
        case .add: return add()
        case .multiply: return multiply()
        case .done: return .done
        }
    }
    
    func add() -> StepResult {
        guard inbounds else { return .failure }
        let first = program[program[pointer + 1]]
        let second = program[program[pointer + 2]]
        program[program[pointer + 3]] = first + second
        pointer += 4
        return .success
    }
    
    func multiply() -> StepResult {
        guard inbounds else { return .failure }
        let first = program[program[pointer + 1]]
        let second = program[program[pointer + 2]]
        program[program[pointer + 3]] = first * second
        pointer += 4
        return .success
    }
}

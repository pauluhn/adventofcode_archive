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
    private let inputs: [Int]
    private(set) var outputs: [Int] = []
    
    enum Opcode {
        case add(PM, PM)
        case multiply(PM, PM)
        case input
        case output
        case done
    }
    
    typealias PM = ParameterMode
    enum ParameterMode: Int {
        case position   = 0
        case immediate  = 1
    }
    
    enum StepResult {
        case success
        case failure
        case done
    }
    
    init(program: [Int], inputs: [Int] = []) {
        self.program = program
        self.inputs = inputs
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
        let value = program[pointer]
        let opcode = value % 100
        let pm1 = PM(rawValue: (value / 100) % 10)!
        let pm2 = PM(rawValue: (value / 1000) % 10)!
        
        switch opcode {
        case 1: return .add(pm1, pm2)
        case 2: return .multiply(pm1, pm2)
        case 3: return .input
        case 4: return .output
        case 99: return .done
        default: fatalError()
        }
    }
    
    func step() -> StepResult {
        switch opcode {
        case let .add(pm1, pm2): return add(pm1, pm2)
        case let .multiply(pm1, pm2): return multiply(pm1, pm2)
        case .input: return input()
        case .output: return output()
        case .done: return .done
        }
    }
    
    func add(_ pm1: PM, _ pm2: PM) -> StepResult {
        guard inbounds(pm1, pm2, .position) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        program[program[pointer + 3]] = first + second
        pointer += 4
        return .success
    }
    
    func multiply(_ pm1: PM, _ pm2: PM) -> StepResult {
        guard inbounds(pm1, pm2, .position) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        program[program[pointer + 3]] = first * second
        pointer += 4
        return .success
    }
    
    func input() -> StepResult {
        guard inbounds(.position),
            let first = inputs.first else { return .failure }
        program[program[pointer + 1]] = first
        pointer += 2
        return .success
    }
    
    func output() -> StepResult {
        guard inbounds(.position) else { return .failure }
        let first = program[program[pointer + 1]]
        outputs.append(first)
        print("output:", first)
        pointer += 2
        return .success
    }
    
    private func inbounds(_ parameters: PM...) -> Bool {
        for (i, pm) in parameters.enumerated() where pm == .position {
            if program[pointer + i + 1] >= program.count {
                return false
            }
        }
        return true
    }
    
    private func parameters(_ pm1: PM, _ pm2: PM) -> (Int, Int) {
        return (parameter(1, pm1), parameter(2, pm2))
    }
    
    private func parameter(_ offset: Int, _ pm: PM) -> Int {
        switch pm {
        case .position: return program[program[pointer + offset]]
        case .immediate: return program[pointer + offset]
        }
    }
}

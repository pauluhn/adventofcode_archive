//
//  IntcodeComputer.swift
//  aoc
//
//  Created by Paul Uhn on 12/5/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

class IntcodeComputer {
    struct Memory {
        private var memory = [Int: Int]()
        private(set) var count = 0
        init(_ program: [Int]) {
            for (n, i) in program.enumerated() {
                memory[n] = i
            }
            count = program.count
        }
        subscript(index: Int) -> Int {
            get {
                guard let value = memory[index] else { return 0 }
                return value
            }
            set(value) {
                memory[index] = value
                if count < index + 1 {
                    count = index + 1
                }
            }
        }
        var program: [Int] {
            var program = Array(repeating: 0, count: count)
            for i in 0..<count {
                program[i] = self[i]
            }
            return program
        }
    }
    
    private var pointer = 0
    private(set) var inputs: [Int]
    private(set) var outputs: [Int] = []
    private var relativeBase = 0
    private let limitedMemory: Bool
    private var memory: Memory
    
    typealias OutputHandler = (Int) -> Void
    private let outputHandler: OutputHandler?
    
    enum Opcode {
        case add(PM, PM, PM)
        case multiply(PM, PM, PM)
        case input(PM)
        case output(PM)
        case jumpIfTrue(PM, PM)
        case jumpIfFalse(PM, PM)
        case lessThan(PM, PM, PM)
        case equals(PM, PM, PM)
        case adjustRelativeBase(PM)
        case done
    }
    
    typealias PM = ParameterMode
    enum ParameterMode: Int {
        case position   = 0
        case immediate  = 1
        case relative   = 2
    }
    
    enum StepResult {
        case success
        case failure
        case done
    }
    
    init(program: [Int],
         inputs: [Int] = [],
         outputHandler: OutputHandler? = nil) {
        
        memory = Memory(program)
        self.inputs = inputs
        self.outputHandler = outputHandler
        self.limitedMemory = true
    }
    
    init(program: [Int],
         inputs: [Int] = [],
         limitedMemory: Bool,
         outputHandler: OutputHandler? = nil) {
        
        memory = Memory(program)
        self.inputs = inputs
        self.outputHandler = outputHandler
        self.limitedMemory = limitedMemory
    }
    
    func run() -> Memory? {
        while true {
            switch step() {
            case .success: break
            case .failure: return nil
            case .done: return memory
            }
        }
    }
    
    func appendInput(_ input: Int) {
        inputs.append(input)
    }
    
    func tick() -> Bool { // keep going?
        switch step() {
        case .success: return true
        case .failure: return false
        case .done: return false
        }
    }
}

private extension IntcodeComputer {
    var opcode: Opcode {
        let value = memory[pointer]
        let opcode = value % 100
        let pm1 = PM(rawValue: (value / 100) % 10)!
        let pm2 = PM(rawValue: (value / 1000) % 10)!
        let pm3 = PM(rawValue: (value / 10000) % 10)!

        switch opcode {
        case 1: return .add(pm1, pm2, pm3)
        case 2: return .multiply(pm1, pm2, pm3)
        case 3: return .input(pm1)
        case 4: return .output(pm1)
        case 5: return .jumpIfTrue(pm1, pm2)
        case 6: return .jumpIfFalse(pm1, pm2)
        case 7: return .lessThan(pm1, pm2, pm3)
        case 8: return .equals(pm1, pm2, pm3)
        case 9: return .adjustRelativeBase(pm1)
        case 99: return .done
        default: fatalError()
        }
    }
    
    func step() -> StepResult {
        switch opcode {
        case let .add(pm1, pm2, pm3): return add(pm1, pm2, pm3)
        case let .multiply(pm1, pm2, pm3): return multiply(pm1, pm2, pm3)
        case .input(let pm1): return input(pm1)
        case .output(let pm1): return output(pm1)
        case let .jumpIfTrue(pm1, pm2): return jumpIfTrue(pm1, pm2)
        case let .jumpIfFalse(pm1, pm2): return jumpIfFalse(pm1, pm2)
        case let .lessThan(pm1, pm2, pm3): return lessThan(pm1, pm2, pm3)
        case let .equals(pm1, pm2, pm3): return equals(pm1, pm2, pm3)
        case .adjustRelativeBase(let pm1): return adjustRelativeBase(pm1)
        case .done: return .done
        }
    }
    
    func add(_ pm1: PM, _ pm2: PM, _ pm3: PM) -> StepResult {
        guard inbounds(pm1, pm2, .position) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        parameter(3, pm3, first + second)
        pointer += 4
        return .success
    }
    
    func multiply(_ pm1: PM, _ pm2: PM, _ pm3: PM) -> StepResult {
        guard inbounds(pm1, pm2, .position) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        parameter(3, pm3, first * second)
        pointer += 4
        return .success
    }
    
    func input(_ pm1: PM) -> StepResult {
        guard inbounds(pm1) else { return .failure }
        guard !inputs.isEmpty else { return .success } // waiting
        let first = inputs.removeFirst()
        parameter(1, pm1, first)
        pointer += 2
        return .success
    }
    
    func output(_ pm1: PM) -> StepResult {
        guard inbounds(pm1) else { return .failure }
        let first = parameter(1, pm1)
        outputs.append(first)
        print("output:", first)
        outputHandler?(first)
        pointer += 2
        return .success
    }
    
    func jumpIfTrue(_ pm1: PM, _ pm2: PM) -> StepResult {
        guard inbounds(pm1, pm2) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        if first != 0 {
            pointer = second
        } else {
            pointer += 3
        }
        return .success
    }
    
    func jumpIfFalse(_ pm1: PM, _ pm2: PM) -> StepResult {
        guard inbounds(pm1, pm2) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        if first == 0 {
            pointer = second
        } else {
            pointer += 3
        }
        return .success
    }
    
    func lessThan(_ pm1: PM, _ pm2: PM, _ pm3: PM) -> StepResult {
        guard inbounds(pm1, pm2, .position) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        parameter(3, pm3, first < second ? 1 : 0)
        pointer += 4
        return .success
    }
    
    func equals(_ pm1: PM, _ pm2: PM, _ pm3: PM) -> StepResult {
        guard inbounds(pm1, pm2, .position) else { return .failure }
        let (first, second) = parameters(pm1, pm2)
        parameter(3, pm3, first == second ? 1 : 0)
        pointer += 4
        return .success
    }
    
    func adjustRelativeBase(_ pm1: PM) -> StepResult {
        guard inbounds(pm1) else { return .failure }
        let first = parameter(1, pm1)
        relativeBase += first
        pointer += 2
        return .success
    }
    
    private func inbounds(_ parameters: PM...) -> Bool {
        guard limitedMemory else { return true }
        for (i, pm) in parameters.enumerated() where pm == .position {
            if memory[pointer + i + 1] >= memory.count {
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
        case .position: return memory[memory[pointer + offset]]
        case .immediate: return memory[pointer + offset]
        case .relative: return memory[relativeBase + memory[pointer + offset]]
        }
    }
    
    private func parameter(_ offset: Int, _ pm: PM, _ value: Int) {
        switch pm {
        case .position: memory[memory[pointer + offset]] = value
        case .immediate: memory[pointer + offset] = value
        case .relative: memory[relativeBase + memory[pointer + offset]] = value
        }
    }
}

//
//  2017Day18.swift
//  aoc
//
//  Created by Paul Uhn on 11/29/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day18 {
    
    struct Runloop {
        var program: Program
        let instructions: [Instruction]
        private(set) var index = 0
        init(_ program: Program, _ instructions: [Instruction]) {
            self.program = program
            self.instructions = instructions
        }
        
        enum Result {
            case message(Int)
            case done
            case none
        }
        mutating func step() -> Result {
            guard index < instructions.count else { return .done }
            switch program.run(instructions[index]) {
            case .message(let msg):
                index += 1
                return .message(msg)
            case .done:
                index += 1
                return .done
            case .offset(let value):
                index += value
            case .none:
                index += 1
            }
            return .none
        }
    }
    
    struct Program {
        let id: Int
        let isPart2: Bool
        private(set) var registers: Registers
        private(set) var queue = [Int]()
        private(set) var isWaiting = false
        
        init(id: Int, isPart2: Bool = false) {
            self.id = id
            self.isPart2 = isPart2
            registers = isPart2 ? Registers(p: id) : Registers()
        }
        
        enum Result {
            case message(Int)
            case done
            case offset(Int)
            case none
        }
        mutating func run(_ instruction: Instruction) -> Result {
            switch instruction.mode {
            case let .send(first):
                return .message(registers.get(first))
            case let .set(first, second):
                registers.set(first, value: registers.get(second))
            case let .increase(first, second):
                let x = registers.get(first)
                let y = registers.get(second)
                registers.set(first, value: x + y)
            case let .multiply(first, second):
                let x = registers.get(first)
                let y = registers.get(second)
                registers.set(first, value: x * y)
            case let .remainder(first, second):
                let x = registers.get(first)
                let y = registers.get(second)
                registers.set(first, value: x % y)
            case let .receive(first):
                if !isPart2 {
                    if registers.get(first) != 0 {
                        return .done
                    }
                } else {
                    guard !queue.isEmpty else {
                        isWaiting = true
                        return .offset(0)
                    }
                    isWaiting = false
                    guard case let .register(x) = first else { fatalError() }
                    let y = queue.removeFirst()
                    registers.set(x, value: y)
                }
            case let .jumps(first, second):
                if registers.get(first) > 0 {
                    return .offset(registers.get(second))
                }
            }
            return .none
        }
        
        mutating func add(message: Int) {
            guard isPart2 else { return }
            queue.append(message)
        }
    }
    
    struct Instruction {
        enum Value: Hashable {
            case register(String)
            case integer(Int)
        }
        enum Mode: Hashable {
            case send(Value)
            case set(String, Value)
            case increase(String, Value)
            case multiply(String, Value)
            case remainder(String, Value)
            case receive(Value) // check not zero
            case jumps(Value, Value) // check greater than zero
        }
        let mode: Mode
        
        init?(_ data: String) {
            let components = data.split(separator: " ")
            guard !components.isEmpty else { return nil }
            
            let instruction = components[0].str
            let first = components[1].str
            let second = components.last!.str
            
            switch instruction {
            case "snd": mode = .send(first.value)
            case "set": mode = .set(first, second.value)
            case "add": mode = .increase(first, second.value)
            case "mul": mode = .multiply(first, second.value)
            case "mod": mode = .remainder(first, second.value)
            case "rcv": mode = .receive(first.value)
            case "jgz": mode = .jumps(first.value, second.value)
            default: fatalError()
            }
        }
    }
    
    struct Registers {
        private var registers = [String: Int]()
        init() {}
        init(p: Int) {
            registers["p"] = p
        }
        func get(_ register: String) -> Int {
            return get(.register(register))
        }
        func get(_ register: Instruction.Value) -> Int {
            switch register {
            case .register(let r):
                guard let value = registers[r] else { return 0 }
                return value
            case .integer(let i):
                return i
            }
        }
        mutating func set(_ register: String, value: Int) {
            registers[register] = value
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        assert(Instruction("snd a")!.mode == Instruction.Mode.send("a".value))
        assert(Instruction("set a 1")!.mode == Instruction.Mode.set("a", "1".value))
        assert(Instruction("add a 1")!.mode == Instruction.Mode.increase("a", "1".value))
        assert(Instruction("mul a 1")!.mode == Instruction.Mode.multiply("a", "1".value))
        assert(Instruction("mod a 1")!.mode == Instruction.Mode.remainder("a", "1".value))
        assert(Instruction("rcv a")!.mode == Instruction.Mode.receive("a".value))
        assert(Instruction("jgz a -1")!.mode == Instruction.Mode.jumps("a".value, "-1".value))
        
        var instructions = data.compactMap(Instruction.init)
        var program = Program(id: 0)
        var message = 0
        var done = false
        var i = 0
        
        while !done {
            if i >= instructions.count {
                done = true
                continue
            }
            
            switch program.run(instructions[i]) {
            case .message(let text):
                message = text
            case .done:
                done = true
                continue
            case .offset(let value):
                i += value
                continue
            case .none:
                break
            }
            i += 1
        }
        return message
    }
    
    static func Part2(_ data: [String]) -> Int {
        let instructions = data.compactMap(Instruction.init)
        var runloops = [
            Runloop(Program(id: 0, isPart2: true), instructions),
            Runloop(Program(id: 1, isPart2: true), instructions)]
        var done1 = false
        var done2 = false
        var count = 0

        while !done1 || !done2 {
            if !done1 {
                switch runloops[0].step() {
                case .message(let msg):
                    runloops[1].program.add(message: msg)
                case .done:
                    done1 = true
                case .none:
                    break
                }
            }
            if !done1 {
                switch runloops[1].step() {
                case .message(let msg):
                    runloops[0].program.add(message: msg)
                    count += 1
                case .done:
                    done2 = true
                case .none:
                    break
                }
            }
            // check deadlock
            if runloops[0].program.isWaiting && runloops[1].program.isWaiting {
                return count
            }
        }
        return count
    }
}

private extension String {
    typealias Value = Y2017Day18.Instruction.Value
    var value: Value {
        if let integer = Int(self) {
            return .integer(integer)
        } else {
            return .register(self)
        }
    }
}

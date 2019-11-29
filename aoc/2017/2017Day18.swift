//
//  2017Day18.swift
//  aoc
//
//  Created by Paul Uhn on 11/29/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day18 {
    
    struct Instruction {
        enum Value: Hashable {
            case register(String)
            case integer(Int)
        }
        enum Mode: Hashable {
            case play(Value)
            case set(String, Value)
            case increase(String, Value)
            case multiply(String, Value)
            case remainder(String, Value)
            case recover(Value) // check not zero
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
            case "snd": mode = .play(first.value)
            case "set": mode = .set(first, second.value)
            case "add": mode = .increase(first, second.value)
            case "mul": mode = .multiply(first, second.value)
            case "mod": mode = .remainder(first, second.value)
            case "rcv": mode = .recover(first.value)
            case "jgz": mode = .jumps(first.value, second.value)
            default: fatalError()
            }
        }
    }
    
    private struct Registers {
        private var registers = [String: Int]()
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
        assert(Instruction("snd a")!.mode == Instruction.Mode.play("a".value))
        assert(Instruction("set a 1")!.mode == Instruction.Mode.set("a", "1".value))
        assert(Instruction("add a 1")!.mode == Instruction.Mode.increase("a", "1".value))
        assert(Instruction("mul a 1")!.mode == Instruction.Mode.multiply("a", "1".value))
        assert(Instruction("mod a 1")!.mode == Instruction.Mode.remainder("a", "1".value))
        assert(Instruction("rcv a")!.mode == Instruction.Mode.recover("a".value))
        assert(Instruction("jgz a -1")!.mode == Instruction.Mode.jumps("a".value, "-1".value))
        
        var instructions = data.compactMap(Instruction.init)
        var registers = Registers()
        var sound = 0
        var done = false
        var i = 0
        
        while !done {
            if i >= instructions.count {
                done = true
                continue
            }
            
            switch instructions[i].mode {
            case let .play(first):
                sound = registers.get(first)
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
            case let .recover(first):
                if registers.get(first) != 0 {
                    done = true
                    continue
                }
            case let .jumps(first, second):
                if registers.get(first) > 0 {
                    i += registers.get(second)
                    continue
                }
            }
            i += 1
        }
        return sound
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

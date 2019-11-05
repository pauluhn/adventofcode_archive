//
//  OpCode.swift
//  aoc
//
//  Created by Paul Uhn on 12/16/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct OpCode {
    typealias Value = Int
    static let initialRegisterValue: Value = 0
    static var registerCount = 4

    // MARK: - Addition
    /// (add register) stores into register C the result of adding register A and register B.
    static func addr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] + registers[B]
    }
    /// (add immediate) stores into register C the result of adding register A and value B.
    static func addi(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] + B
    }
    
    // MARK: - Multiplication
    /// (multiply register) stores into register C the result of multiplying register A and register B.
    static func mulr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] * registers[B]
    }
    /// (multiply immediate) stores into register C the result of multiplying register A and value B.
    static func muli(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] * B
    }
    
    // MARK: - Bitwise AND
    /// (bitwise AND register) stores into register C the result of the bitwise AND of register A and register B.
    static func banr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] & registers[B]
    }
    /// (bitwise AND immediate) stores into register C the result of the bitwise AND of register A and value B.
    static func bani(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] & B
    }
    
    // MARK: - Bitwise OR
    /// (bitwise OR register) stores into register C the result of the bitwise OR of register A and register B.
    static func borr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] | registers[B]
    }
    /// (bitwise OR immediate) stores into register C the result of the bitwise OR of register A and value B.
    static func bori(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] | B
    }
    
    // MARK: - Assignment
    /// (set register) copies the contents of register A into register C. (Input B is ignored.)
    static func setr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A]
    }
    /// (set immediate) stores value A into register C. (Input B is ignored.)
    static func seti(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = A
    }
    
    // MARK: - Greater-than testing
    /// (greater-than immediate/register) sets register C to 1 if value A is greater than register B. Otherwise, register C is set to 0.
    static func gtir(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = A > registers[B] ? 1 : 0
    }
    /// (greater-than register/immediate) sets register C to 1 if register A is greater than value B. Otherwise, register C is set to 0.
    static func gtri(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] > B ? 1 : 0
    }
    /// (greater-than register/register) sets register C to 1 if register A is greater than register B. Otherwise, register C is set to 0.
    static func gtrr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] > registers[B] ? 1 : 0
    }
    
    // MARK: - Equality testing
    /// (equal immediate/register) sets register C to 1 if value A is equal to register B. Otherwise, register C is set to 0.
    static func eqir(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = A == registers[B] ? 1 : 0
    }
    /// (equal register/immediate) sets register C to 1 if register A is equal to value B. Otherwise, register C is set to 0.
    static func eqri(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] == B ? 1 : 0
    }
    /// (equal register/register) sets register C to 1 if register A is equal to register B. Otherwise, register C is set to 0.
    static func eqrr(_ registers: inout [Value], A: Value, B: Value, C: Value) {
        registers[C] = registers[A] == registers[B] ? 1 : 0
    }
}

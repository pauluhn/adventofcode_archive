//
//  OpCodeInstruction.swift
//  aoc
//
//  Created by Paul Uhn on 12/16/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct OpCodeInstruction {
    enum InstructionType {
        case before([OpCode.Value])
        case instruction([OpCode.Value])
        case after([OpCode.Value])
    }
    let type: InstructionType
    
    init?(_ data: String) {
        guard let type = OpCodeInstruction.before(data) ??
            OpCodeInstruction.instruction(data) ??
            OpCodeInstruction.after(data) else { return nil }
        self.type = type
    }
}
private extension OpCodeInstruction {
    static func before(_ data: String) -> InstructionType? {
        let regex = try! NSRegularExpression(pattern: "^Before: \\[(\\d+), (\\d+), (\\d+), (\\d+)\\]$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        return .before([
            data.match(match, at: 1).int,
            data.match(match, at: 2).int,
            data.match(match, at: 3).int,
            data.match(match, at: 4).int])
    }
    static func instruction(_ data: String) -> InstructionType? {
        let regex = try! NSRegularExpression(pattern: "^(\\d+) (\\d+) (\\d+) (\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        return .instruction([
            data.match(match, at: 1).int,
            data.match(match, at: 2).int,
            data.match(match, at: 3).int,
            data.match(match, at: 4).int])
    }
    static func after(_ data: String) -> InstructionType? {
        let regex = try! NSRegularExpression(pattern: "^After:  \\[(\\d+), (\\d+), (\\d+), (\\d+)\\]$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        return .after([
            data.match(match, at: 1).int,
            data.match(match, at: 2).int,
            data.match(match, at: 3).int,
            data.match(match, at: 4).int])
    }
}

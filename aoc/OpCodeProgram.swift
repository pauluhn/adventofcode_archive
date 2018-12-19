//
//  OpCodeProgram.swift
//  aoc
//
//  Created by Paul Uhn on 12/18/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct OpCodeProgram {
    enum OpCodeType: String, CaseIterable {
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
    typealias ProgramLine = (opCode: OpCodeType, values: [OpCode.Value])
    
    let ip: Int
    let lines: [ProgramLine]
    
    init(_ data: [String]) {
        var data = data
        ip = OpCodeProgram.getIp(data.removeFirst())
        lines = data.compactMap(OpCodeProgram.getLine)
    }
}
private extension OpCodeProgram {
    static func getIp(_ data: String) -> Int {
        let regex = try! NSRegularExpression(pattern: "^#ip (\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { fatalError() }
        
        return data.match(match, at: 1).int
    }
    static func getLine(_ data: String) -> ProgramLine? {
        let regex = try! NSRegularExpression(pattern: "^([a-z]{4}) (\\d+) (\\d+) (\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        let opCode = OpCodeType(rawValue: data.match(match, at: 1))!
        let A = data.match(match, at: 2).int
        let B = data.match(match, at: 3).int
        let C = data.match(match, at: 4).int
        return (opCode, [A, B, C])
    }
}

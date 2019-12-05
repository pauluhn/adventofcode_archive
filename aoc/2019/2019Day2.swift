//
//  2019Day2.swift
//  aoc
//
//  Created by Paul Uhn on 12/2/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day2 {
    
    static func Part1(_ data: String, _ enable1202: Bool = false) -> [Int] {
        var program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        if enable1202 {
            program[1] = 12
            program[2] = 2
        }
        
        let intcode = IntcodeComputer(program: program)
        return intcode.run()
    }
    
    static func Part2(_ data: String) -> Int {
        var program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        let answer = 19690720
        
        for i in 0..<100 { // 89
            for j in 0..<100 { // 76
                program[1] = i
                program[2] = j
                let intcode = IntcodeComputer(program: program)
                if let first = intcode.run().first,
                    first == answer {
                        return 100 * i + j
                }
            }
        }
        return 0
    }
}

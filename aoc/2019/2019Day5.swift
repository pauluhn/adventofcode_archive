//
//  2019Day5.swift
//  aoc
//
//  Created by Paul Uhn on 12/5/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day5 {
    
    static func Part1(_ data: String) -> Int {
//        let program = "3,0,4,0,99".split(separator: ",")
//            .map(String.init)
//            .compactMap(Int.init)
//        let intcode = IntcodeComputer(program: program, inputs: [1])
//        intcode.run()
        
//        let program = "1002,4,3,4,33".split(separator: ",")
//            .map(String.init)
//            .compactMap(Int.init)
//        let intcode = IntcodeComputer(program: program, inputs: [1])
//        intcode.run()
        
//        let program = "1101,100,-1,4,0".split(separator: ",")
//            .map(String.init)
//            .compactMap(Int.init)
//        let intcode = IntcodeComputer(program: program, inputs: [1])
//        intcode.run()

        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        let intcode = IntcodeComputer(program: program, inputs: [1])
        _ = intcode.run()

        return intcode.outputs.last ?? 0
    }
}

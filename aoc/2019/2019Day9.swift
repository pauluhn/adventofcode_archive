//
//  2019Day9.swift
//  aoc
//
//  Created by Paul Uhn on 12/9/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day9 {

    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)

        let intcode = IntcodeComputer(program: program,
                                      inputs: [1],
                                      limitedMemory: false)
        let _ = intcode.run()
        return intcode.outputs.last!
    }
}

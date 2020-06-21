//
//  2019Day19.swift
//  aoc
//
//  Created by Paul Uhn on 2/7/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day19 {

    static func Part1(_ data: String, _ size: Int) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var points = [Point]()
        for y in 0..<size {
            for x in 0..<size {
                points.append(Point(x: x, y: y))
            }
        }
        
        var outputs = [Int]()
        points.forEach {
            let intcode = IntcodeComputer(
                program: program,
                inputs: [$0.x, $0.y],
                limitedMemory: false) { outputs.append($0) }
            _ = intcode.run()
        }
        
        var grid = ""
        for (n, output) in outputs.enumerated() {
            if n % size == 0 {
                grid += "\n"
            }
            grid += output == 0 ? "." : "#"
        }
        print(grid)

        return outputs.filter { $0 == 1 }.count
    }
}

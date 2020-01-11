//
//  2019Day17.swift
//  aoc
//
//  Created by Paul Uhn on 1/11/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day17 {

    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)

        var outputs = [Int]()
        let intcode = IntcodeComputer(
            program: program,
            inputs: [],
            limitedMemory: false) {
                outputs.append($0)
        }
        _ = intcode.run()
        
        draw(outputs)
        
        var map = [Point: String]()
        var x = 0
        var y = 0
        for output in outputs {
            if output == 10 {
                y += 1
                x = 0
            } else {
                map[Point(x: x, y: y)] = Ascii(output).value
                x += 1
            }
        }
        
        let intersections = map
            .filter { $0.value == "#" }
            .filter { scaffold in
                Direction.valid
                    .map { scaffold.key.offset(by: $0.offset) }
                    .filter { map[$0] == "#" }
                    .count == 4
            }
        
        return intersections.reduce(0) { $0 + $1.key.x * $1.key.y }
    }
    
    private static func draw(_ map: [Int]) {
        let map = map
            .map { Ascii($0).value }
            .joined()
        print(map)
    }
}

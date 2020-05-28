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
        
        let outputs = points.map { isStationary(program, $0) }
        
        var grid = ""
        for (n, output) in outputs.enumerated() {
            if n % size == 0 {
                grid += "\n"
            }
            grid += output ? "." : "#"
        }
        print(grid)

        return outputs.filter { !$0 }.count
    }
    
    static func Part2(_ data: String, _ size: Int) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var y = size
        var outputs = [Bool]()

        // Phase 1
        while outputs.filter({ !$0 }).count < size {
            let start = outputs.firstIndex(of: false) ?? 0
//            print("\(start),\(y)")
            var rightOfBeam = false
            outputs = []
            for x in start..<y {
                let value = isStationary(program, Point(x: x, y: y))
                outputs.append(value)
                if rightOfBeam, value { break }
                if !value { rightOfBeam = true }
            }
//            print(outputs.map({ $0 ? "." : "#"} ).joined())
            y += 100
        }
        y -= 100
        
        // Phase 2
        struct Scan {
            let size: Int
            private(set) var cache = [Int: Int]()
            init(_ size: Int) { self.size = size }
            mutating func add(_ row: [Bool]) -> Bool {
                for (x, b) in row.enumerated() {
                    if cache[x] == nil { cache[x] = 0 }
                    cache[x] = b ? 0 : cache[x]! + 1
                }
                return cache.filter({ $0.value >= size }).count == size
            }
        }
        var scan = Scan(size)
        repeat {
            let start = outputs.firstIndex(of: false) ?? 0
//            print("\(start),\(y)")
            var rightOfBeam = false
            outputs = []
            for x in start..<y {
                let value = isStationary(program, Point(x: x, y: y))
                outputs.append(value)
                if rightOfBeam, value { break }
                if !value { rightOfBeam = true }
            }
//            print(outputs.map({ $0 ? "." : "#"} ).joined())
            y += 1
            print(scan.cache.filter({ $0.value >= size }).count)

            
//            outputs = (0..<y)
//                .map { Point(x: $0, y: y) }
//                .map { isStationary(program, $0) }
//            print(outputs.map({ $0 ? "." : "#"} ).joined())
//            y += 1
        } while !scan.add(outputs)
        
        // Phase 3
        let x = scan.cache
            .filter { $0.value >= size }
            .sorted { $0.key < $1.key }
            .first!.key

        return x * 10_000 + y - size
    }
    
    private static func isStationary(_ program: [Int], _ point: Point) -> Bool {
        var output: Int!
        let intcode = IntcodeComputer(
            program: program,
            inputs: [point.x, point.y],
            limitedMemory: false,
            displayInput: false,
            displayOutput: false) { output = $0 }
        _ = intcode.run()
        return output == 0
    }
}

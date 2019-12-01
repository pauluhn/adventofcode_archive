//
//  2017Day14.swift
//  aoc
//
//  Created by Paul Uhn on 11/24/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day14 {

    private struct Grid {
        private var grid: [[String]]
        
        init(data: [String]) {
            grid = data.map { $0.map(String.init) }
        }
        
        // screen coordinates
        func get(_ point: Point) -> String {
            guard isValid(point) else { return "" }
            return grid[point.y][point.x]
        }
        
        mutating func set(_ point: Point, to char: String) {
            guard isValid(point) else { return }
            grid[point.y][point.x] = char
        }
        
        func adjacent(_ point: Point) -> [Point] {
            guard isValid(point) else { return [] }
            let directions: [Direction] = [.up, .down, .left, .right]
            return directions.compactMap {
                let newPoint = point.offset(by: $0.offset)
                guard isValid(newPoint) else { return nil }
                return newPoint
            }
        }
        
        private func isValid(_ point: Point) -> Bool {
            return point.x >= 0
                && point.x < grid.count
                && !grid.isEmpty
                && point.y >= 0
                && point.y < grid[0].count
        }
    }
    
    static func Part1(_ data: String) -> Int {
        let rows = grid(data)
        return rows.reduce(0) {
            $0 + $1.reduce(0, { $0 + $1.int })
        }
    }
    
    static func Part2(_ data: String) -> Int {
        var theGrid = Grid(data: grid(data))
        var regions = 0
        for x in 0..<128 {
            for y in 0..<128 {
                let point = Point(x: x, y: y)
                if theGrid.get(point) == "1" {
                    theGrid.set(point, to: "2")
                    regions += 1
                    
                    var points = theGrid.adjacent(point)
                        .filter { theGrid.get($0) == "1" }
                    while !points.isEmpty {
                        let aPoint = points.removeFirst()
                        theGrid.set(aPoint, to: "2")
                        let newPoints = theGrid.adjacent(aPoint)
                            .filter { theGrid.get($0) == "1" }
                        points.append(contentsOf: newPoints)
                    }
                }
            }
        }
        return regions
    }

    private static func grid(_ data: String) -> [String] {
        var rows = [String]()
        for i in 0..<128 {
            let input = "\(data)-\(i)"
            let output = Y2017Day10.Part2(256, input)
            let row = output
                .compactMap { $0.hexDigitValue }
                .map { $0.binaryString(length: 4) }
                .joined()
            if i < 8 {
                print(row.prefix(8))
            }
            rows.append(row)
        }
        return rows
    }
}

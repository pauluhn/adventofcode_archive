//
//  2018Day6.swift
//  aoc
//
//  Created by Paul Uhn on 12/5/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day6 {
    static func Part1(_ data: [String]) -> Int {
        let coords = data.compactMap(Coord.init)
        
        // find max x and y
        let maxX = coords.sorted { $0.x > $1.x }.first.map { $0.x }!
        let maxY = coords.sorted { $0.y > $1.y }.first.map { $0.y }!

        var tracker = Tracker<Coord>()
        var edges = Set<Coord>()
        for x in 0...maxX {
            for y in 0...maxY {
                let other = Coord(x: x, y: y)
                let coordsAndDistance = coords
                    .map { ($0, $0.manhattanDistance(from: other)) }
                    .sorted { $0.1 < $1.1 }
                
                // assume at least 2 coord
                let coord = coordsAndDistance[0].0
                if x == 0 || x == maxX || y == 0 || y == maxY {
                    edges.insert(coord)
                } else if coordsAndDistance[0].1 != coordsAndDistance[1].1 {
                    tracker.add(coord, value: 1)
                }
            }
        }
        return tracker.data
            .sorted { $0.value > $1.value }
            .filter { !edges.contains($0.key) }
            .first!.value
    }
    static func Part2(_ data: [String], _ threshold: Int) -> Int {
        let coords = data.compactMap(Coord.init)

        // find max x and y
        let maxX = coords.sorted { $0.x > $1.x }.first.map { $0.x }!
        let maxY = coords.sorted { $0.y > $1.y }.first.map { $0.y }!

        var runningCount = 0
        for x in 0...maxX {
            for y in 0...maxY {
                let other = Coord(x: x, y: y)
                let totalDistance = coords
                    .map { $0.manhattanDistance(from: other) }
                    .reduce(0, +)
                
                if totalDistance < threshold {
                    runningCount += 1
                }
            }
        }
        return runningCount
    }
}

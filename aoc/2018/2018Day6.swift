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
        let points = data.compactMap(Point.init)
        
        // find max x and y
        let maxX = points.sorted { $0.x > $1.x }.first.map { $0.x }!
        let maxY = points.sorted { $0.y > $1.y }.first.map { $0.y }!

        var tracker = Tracker<Point>()
        var edges = Set<Point>()
        for x in 0...maxX {
            for y in 0...maxY {
                let other = Point(x: x, y: y)
                let pointsAndDistance = points
                    .map { ($0, $0.manhattanDistance(from: other)) }
                    .sorted { $0.1 < $1.1 }
                
                // assume at least 2 points
                let point = pointsAndDistance[0].0
                if x == 0 || x == maxX || y == 0 || y == maxY {
                    edges.insert(point)
                } else if pointsAndDistance[0].1 != pointsAndDistance[1].1 {
                    tracker.add(point, value: 1)
                }
            }
        }
        return tracker.data
            .sorted { $0.value > $1.value }
            .filter { !edges.contains($0.key) }
            .first!.value
    }
    static func Part2(_ data: [String], _ threshold: Int) -> Int {
        let points = data.compactMap(Point.init)

        // find max x and y
        let maxX = points.sorted { $0.x > $1.x }.first.map { $0.x }!
        let maxY = points.sorted { $0.y > $1.y }.first.map { $0.y }!

        var runningCount = 0
        for x in 0...maxX {
            for y in 0...maxY {
                let other = Point(x: x, y: y)
                let totalDistance = points
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

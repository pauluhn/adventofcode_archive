//
//  2019Day10.swift
//  aoc
//
//  Created by Paul Uhn on 12/10/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day10 {
    
    static func Part1(_ data: [String]) -> Int {
        let asteroids = generateMap(data)
        var removed = Set<Point>()
        var maxDetect = 0
        
        for asteroid in asteroids {
            let remaining = asteroids
                .removing(asteroid)
            for blocking in remaining {
                let diff = offset(asteroid, blocking)
                var remove = blocking + diff
                while remove.x < data[0].count
                    && remove.y < data.count
                    && remove.x >= 0
                    && remove.y >= 0 {
                        removed.insert(remove)
                        remove = remove + diff // TODO: add +=
                }
            }
            let detect = remaining
                .subtracting(removed)
                .count
            print(asteroid, detect)
            removed = []
            if maxDetect < detect {
                maxDetect = detect
            }
        }
        return maxDetect
    }
}

private extension Y2019Day10 {
    static func generateMap(_ data: [String]) -> Set<Point> {
        var asteroids = Set<Point>()
        for (y, row) in data.enumerated() {
            for (x, position) in row.enumerated() where position == "#" {
                asteroids.insert(Point(x: x, y: y))
            }
        }
        return asteroids
    }
    
    static func offset(_ origin: Point, _ destination: Point) -> Point {
        guard origin != destination else { return .zero }
        let diff = destination - origin
        if diff.x == 0 {
            return Point(x: 0, y: diff.y / abs(diff.y))
        } else if diff.y == 0 {
            return Point(x: diff.x / abs(diff.x), y: 0)
        } else {
            return diff / abs(GCD(diff.x, diff.y))
        }
    }
}

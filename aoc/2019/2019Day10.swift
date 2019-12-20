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
                        remove += diff
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
    
    static func Part2(_ data: [String], _ laser: String, _ number: Int) -> Int {
        let laser = Point(laser)!
        let asteroids = generateMap(data)
            .removing(laser)
            .sort(vaporize: laser)
        
        for asteroid in asteroids {
            print(asteroid, angle(laser, asteroid))
        }
        let asteroid = asteroids[number - 1]
        return asteroid.x * 100 + asteroid.y
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
    
    static func angle(_ origin: Point, _ destination: Point) -> Double {
        let diff = offset(origin, destination)
        switch (diff.x, diff.y) {
        case (0, let y) where y > 0: return 90 // N
        case (0, let y) where y < 0: return 270 // S
        case (let x, 0) where x > 0: return 0 // E
        case (let x, 0) where x < 0: return 180 // W
        default: break
        }
        let radians = atan2(Double(diff.y), Double(diff.x))
        let degrees = radians * 180.0 / .pi
        return degrees > 0.0 ? degrees : 360 + degrees
    }
}

private extension Collection where Element == Point {
    func sort(vaporize laser: Point) -> [Point] {
        // sorted by angle
        let byDegrees = self
            .map { ($0, Y2019Day10.angle(laser, $0), $0.manhattanDistance(from: laser)) }
            .sorted { sorted(angle1: $0.1, angle2: $1.1) }
        // same angle, sorted by distance
        let groups = Dictionary(grouping: byDegrees) { $0.1 }
            .filter { $0.value.count > 1 }
            .sorted { sorted(angle1: $0.key, angle2: $1.key) }
            .map {
                $0.value
                    .sorted { $0.2 < $1.2 }
                    .map { $0.0 }
            }
        // final sort
        var rotations = [byDegrees.map { $0.0 }]
        for group in groups {
            for (n, point) in group.enumerated() where n > 0 {
                rotations[0].removeAll { $0 == point }
                while n >= rotations.count {
                    rotations.append([])
                }
                rotations[n].append(point)
            }
        }
        let final = rotations.flatMap { $0 }
        return final
    }
    
    private func sorted(angle1: Double, angle2: Double) -> Bool {
        let up = 270.0
        if angle1 >= up && angle2 < up {
            return true
        } else if angle2 >= up && angle1 < up {
            return false
        } else {
            return angle1 < angle2
        }
    }
}

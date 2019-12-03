//
//  2019Day3.swift
//  aoc
//
//  Created by Paul Uhn on 12/3/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day3 {
    
    struct Path {
        let direction: Direction
        let distance: Int
        
        init?(_ data: Substring) {
            var data = data
            
            let first = data.removeFirst()
            switch first {
            case "U": direction = .up
            case "R": direction = .right
            case "D": direction = .down
            case "L": direction = .left
            default: return nil
            }
            
            distance = Int(data) ?? 0
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        let wires = data.map {
            $0.split(separator: ",").compactMap(Path.init) }
        
        let first = wires[0].points
        let second = wires[1].points
        
        let intersects = first.intersection(second)
        let closest = intersects
            .map { ($0, $0.manhattanDistance(from: .zero)) }
            .sorted { $0.1 < $1.1 }
            .map { $0.0 }
            .first!
        
        return abs(closest.x) + abs(closest.y)
    }
}

private extension Collection where Element == Y2019Day3.Path {
    var points: Set<Point> {
        var set = Set<Point>()
        var current = Point.zero
        for path in self {
            let offset = path.direction.offset
            for _ in 0..<path.distance {
                current = current.offset(by: offset)
                set.insert(current)
            }
        }
        return set
    }
}

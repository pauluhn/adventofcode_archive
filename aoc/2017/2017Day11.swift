//
//  2017Day11.swift
//  aoc
//
//  Created by Paul Uhn on 11/11/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day11 {
    
    static func Part1(_ data: String) -> Int {
        let directions = data.split(separator: ",")
            .map(String.init)
            .compactMap { HexGrid.Direction(rawValue: $0) }
        
        let grid = HexGrid()
        directions.forEach {
            grid.step($0)
        }
        
        var steps = 0
        var current = grid.current
        while current != Point(x: 0, y: 0) {
            let direction = directionBackToOrigin(current)
            current = current.move(in: direction)
            steps += 1
        }
        
        return steps
    }
    
    static func Part2(_ data: String) -> Int {
        let directions = data.split(separator: ",")
            .map(String.init)
            .compactMap { HexGrid.Direction(rawValue: $0) }
        
        let grid = HexGrid()
        var maxSteps = 0
        
        directions.forEach {
            grid.step($0)

            var steps = 0
            var current = grid.current
            while current != Point(x: 0, y: 0) {
                let direction = directionBackToOrigin(current)
                current = current.move(in: direction)
                steps += 1
            }
            
            if steps > maxSteps {
                maxSteps = steps
            }
        }
        return maxSteps
    }
    
    private static func directionBackToOrigin(_ point: Point) -> HexGrid.Direction {
        switch (point.x, point.y) {
        case (0, let y) where y > 0: return .n
        case (0, let y) where y < 0: return .s
        case let (x, y) where x > 0 && y >= 0: return .nw
        case let (x, y) where x > 0 && y < 0: return .sw
        case let (x, y) where x < 0 && y >= 0: return .ne
        case let (x, y) where x < 0 && y < 0: return .se
        default: return .x
        }
    }
}

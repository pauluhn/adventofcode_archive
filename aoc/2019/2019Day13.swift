//
//  2019Day13.swift
//  aoc
//
//  Created by Paul Uhn on 12/21/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day13 {
    
    enum Tile: Int, CustomStringConvertible {
        case empty, wall, block, paddle, ball
        var description: String {
            switch self {
            case .empty: return "."
            case .wall: return "#"
            case .block: return "+"
            case .paddle: return "="
            case .ball: return "@"
            }
        }
    }
    
    enum State {
        case x, y, tile
    }
    
    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var state = State.x
        var point = Point.zero
        var map = [Point: Tile]()
        
        let intcode = IntcodeComputer(
            program: program,
            limitedMemory: false) {
                switch state {
                case .x:
                    point = Point(x: $0, y: point.y)
                    state = .y
                case .y:
                    point = Point(x: point.x, y: $0)
                    state = .tile
                case .tile:
                    map[point] = Tile(rawValue: $0)
                    state = .x
                }
        }
        var tick = false
        repeat { tick = intcode.tick() } while tick
        
        return map.filter { $0.value == .block }.count
    }
    
}


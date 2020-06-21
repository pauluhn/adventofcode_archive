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
            case .ball: return "o"
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
    
    static func Part2(_ data: String) -> Int {
        var data = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        data[0] = 2 // play for free
        let program = data
        
        var state = State.x
        var point = Point.zero
        var map = [Point: Tile]()
        var score = 0
        let p = Point(x: -1, y: 0)
        var minX = Int.max
        var maxX = Int.min
        var minY = Int.max
        var maxY = Int.min
        var ball = Point.zero
        var paddle = Point.zero
        
        func draw(_ map: [Point: Tile]) {
            for y in minY...maxY {
                var row = ""
                for x in minX...maxX {
                    if let pixel = map[Point(x: x, y: y)] {
                        row.append(pixel.description)
                    } else {
                        row.append(".")
                    }
                }
                print(row)
            }
        }
        
        var intcode: IntcodeComputer!
        intcode = IntcodeComputer(
            program: program,
            limitedMemory: false) {
                switch state {
                case .x:
                    if $0 < minX { minX = $0 }
                    if $0 > maxX { maxX = $0 }
                    point = Point(x: $0, y: point.y)
                    state = .y
                case .y:
                    if $0 < minY { minY = $0 }
                    if $0 > maxY { maxY = $0 }
                    point = Point(x: point.x, y: $0)
                    state = .tile
                case .tile:
                    if point == p {
                        score = $0
                    } else {
                        let tile = Tile(rawValue: $0)
                        map[point] = tile
                        
                        switch tile {
                        case .paddle?:
                            paddle = point
                        case .ball?:
                            ball = point
                            if paddle.x == ball.x {
                                intcode.appendInput(0)
                            } else {
                                intcode.appendInput(paddle.x < ball.x ? 1 : -1)
                            }
                            draw(map)
                        default: break
                        }
                    }
                    state = .x
                }
        }
        var tick = false
        repeat { tick = intcode.tick() } while tick
        
        return score
    }
}


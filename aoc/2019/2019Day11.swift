//
//  2019Day11.swift
//  aoc
//
//  Created by Paul Uhn on 12/14/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day11 {
    struct Robot {
        private var current = Point.zero
        private var direction = Direction.up
        
        enum Color: Int { case black, white }
        private(set) var map = [Point: Color]()
        
        enum Input: Int { case paint, turn }
        private var input = Input.paint
        
        var color: Color {
            guard let color = map[current] else { return .black }
            return color
        }
        
        mutating func process(input value: Int) -> Color? {
            switch input {
            case .paint:
                input = .turn
                map[current] = Color(rawValue: value)
                return nil
            case .turn:
                input = .paint
                if value == 0 {
                    direction = direction.turnLeft
                } else if value == 1 {
                    direction = direction.turnRight
                } else {
                    print("unknown value for turn:", value)
                }
                current = current.offset(by: direction.offset)
                return color
            }
        }
    }
    
    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var robot = Robot()
        var intcode: IntcodeComputer!
        intcode = IntcodeComputer(
            program: program,
            inputs: [robot.color.rawValue],
            limitedMemory: false) {
                if let color = robot.process(input: $0) {
                    intcode.appendInput(color.rawValue)
                }
        }
        var tick = false
        repeat { tick = intcode.tick() } while tick
        
        return robot.map.count
    }
}

private extension Direction {
    var turnLeft: Direction {
        switch self {
        case .up: return .left
        case .left: return .down
        case .down: return .right
        case .right: return .up
        case .none: return .none
        }
    }
    var turnRight: Direction {
        switch self {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
        case .none: return .none
        }
    }
}

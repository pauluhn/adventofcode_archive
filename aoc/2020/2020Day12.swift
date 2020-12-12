//
//  2020Day12.swift
//  aoc
//
//  Created by Paul U on 12/12/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day12 {

    enum Action: Character {
        case north = "N"
        case south = "S"
        case east = "E"
        case west = "W"
        case left = "L"
        case right = "R"
        case forward = "F"
    }
    struct Instruction {
        let action: Action
        let value: Int
        init?(_ data: String) {
            var data = data
            guard !data.isEmpty,
                  let action = Action(rawValue: data.removeFirst()) else { return nil }
            self.action = action
            value = data.int
        }
    }
    struct Ship {
        var facing: Action = .east
        var position: Point
    }
    
    static func Part1(_ data: [String]) -> Int {
        var ship = Ship(position: .zero)
        
        for instruction in data.compactMap(Instruction.init) {
            var action = instruction.action
            if action == .forward {
                action = ship.facing
            }
            switch action {
            case .north: ship.position += Point(x: 0, y: -instruction.value)
            case .south: ship.position += Point(x: 0, y: instruction.value)
            case .east: ship.position += Point(x: -instruction.value, y: 0)
            case .west: ship.position += Point(x: instruction.value, y: 0)
            case .left: ship.facing = ship.facing.rotate(in: .left, by: instruction.value)
            case .right: ship.facing = ship.facing.rotate(in: .right, by: instruction.value)
            case .forward: fatalError()
            }
        }
        return ship.position.manhattanDistance(from: .zero)
    }
}

private extension Y2020Day12.Action {
    typealias Action = Y2020Day12.Action
    func rotate(in direction: Action, by value: Int) -> Action {
        guard direction == .left || direction == .right else { fatalError() }
        guard self == .north || self == .south || self == .east || self == .west else { fatalError() }
        var action = self
        switch value {
        case 270: action = action.rotate(in: direction); fallthrough
        case 180: action = action.rotate(in: direction); fallthrough
        case 90: action = action.rotate(in: direction)
        default: fatalError()
        }
        return action
    }
    private func rotate(in direction: Action) -> Action {
        switch (self, direction) {
        case (.north, .left): return .west
        case (.north, .right): return .east
        case (.south, .left): return .east
        case (.south, .right): return .west
        case (.east, .left): return .north
        case (.east, .right): return .south
        case (.west, .left): return .south
        case (.west, .right): return .north
        default: return self
        }
    }
}

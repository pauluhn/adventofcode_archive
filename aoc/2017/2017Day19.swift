//
//  2017Day19.swift
//  aoc
//
//  Created by Paul Uhn on 11/30/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day19 {
    struct Map {
        private(set) var map: [[Character]]
        private(set) var current: Point
        private(set) var facing: Direction
        private(set) var letters: [Character]
        
        enum Tile {
            case track
            case letter(Character)
            case none
            
            var canMove: Bool {
                switch self {
                case .track, .letter: return true
                case .none: return false
                }
            }
        }
        
        init(_ data: [String]) {
            map = data.map { $0.map { $0 } }
            let max = map
                .map { $0.count }
                .max() ?? 0
            for i in 0..<map.count {
                guard map[i].count < max else { continue }
                let padding = Array<Character>(repeating: " ", count: max - map[i].count)
                map[i].append(contentsOf: padding)
            }
            
            guard let top = map.first,
                let x = top.index(of: "|") else {
                    fatalError()
            }
            current = Point(x: x, y: 0)
            facing = .down
            
            letters = map.flatMap { $0.filter { $0.isLetter } }
        }
        
        func look(in direction: Direction) -> Tile {
            guard let next = point(in: direction) else { return .none }
            return tile(at: next)
        }
        
        mutating func move(in direction: Direction) {
            guard look(in: direction).canMove,
                let next = point(in: direction) else { return }
            current = next
        }
        
        mutating func rotate(in direction: Direction) {
            facing = direction
        }
        
        private func point(in direction: Direction) -> Point? {
            let next = current.offset(by: direction.offset)
            guard next.x >= 0, next.y >= 0 else { return nil }
            return next
        }
        
        private func tile(at point: Point) -> Tile {
            guard point.y < map.count,
                let first = map.first, point.x < first.count else {
                    return .none
            }
            let tile = map[point.y][point.x]
            switch tile {
            case "|", "-", "+": return .track
            case " ": return .none
            default: return .letter(tile)
            }
        }
    }
    
    struct Decision {
        let point: Point
        var direction: Direction
    }

    static func Part1(_ data: [String], _ decisions: [Decision] = []) -> String {
        var map = Map(data)
        var characters = [Character]()
        
        while true {
            // always move in same direction
            switch map.look(in: map.facing) {
            case .letter(let c):
                characters.append(c)
                fallthrough
            case .track:
                map.move(in: map.facing)
            case .none:
                // look left/right first
                let left = map.look(in: map.facing.left).canMove
                let right = map.look(in: map.facing.right).canMove
                
                switch (left, right) {
                case (true, true):
                    // problem is what if it can go left and right????
                    if let decision = decisions.first(where: { $0.point == map.current }) {
                        map.rotate(in: decision.direction)
                    } else {
                        print("\(map.current), \(map.facing.left) or \(map.facing.right)")
                        fallthrough
                    }
                    
                case (true, false):
                    map.rotate(in: map.facing.left)

                case (false, true):
                    map.rotate(in: map.facing.right)

                case (false, false):
                    print("done")
                    return String(characters)
                }
            }
        }
    }
}

private extension Direction {
    var left: Direction {
        switch self {
        case .up: return .left
        case .left: return .down
        case .down: return .right
        case .right: return .up
        case .none: return .none
        }
    }
    var right: Direction {
        switch self {
        case .up: return .right
        case .right: return .down
        case .down: return .left
        case .left: return .up
        case .none: return .none
        }
    }
}

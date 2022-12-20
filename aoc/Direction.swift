//
//  Direction.swift
//  aoc
//
//  Created by Paul Uhn on 12/13/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

enum Direction {
    case up
    case down
    case left
    case right
    case none
    
    static var valid: [Direction] = [.up, .down, .left, .right]
}
extension Direction {
    var offset: Point {
        switch self {
        case .up: return Point(x: 0, y: -1)
        case .left: return Point(x: -1, y: 0)
        case .right: return Point(x: 1, y: 0)
        case .down: return Point(x: 0, y: 1)
        case .none: return Point(x: 0, y: 0)
        }
    }
    var vector: Vector2 {
        switch self {
        case .up: return Vector2.up
        case .left: return Vector2.left
        case .right: return Vector2.right
        case .down: return Vector2.down
        case .none: return Vector2.zero
        }
    }
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

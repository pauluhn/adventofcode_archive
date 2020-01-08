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
}

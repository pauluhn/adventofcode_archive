//
//  HexGrid.swift
//  aoc
//
//  Created by Paul Uhn on 11/11/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

class HexGrid {
    enum Direction: String {
        case n, ne, se, s, sw, nw, x
    }
    
    private let origin: Point
    private(set) var current: Point
    
    init() {
        origin = Point(x: 0, y: 0)
        current = origin
    }
    
    func step(_ direction: Direction) {
        current = current.move(in: direction)
    }
}

extension Point {
    func move(in direction: HexGrid.Direction) -> Point {
        switch direction {
        case .n: return offset(by: 0, -2)
        case .ne: return offset(by: 1, -1)
        case .se: return offset(by: 1, 1)
        case .s: return offset(by: 0, 2)
        case .sw: return offset(by: -1, 1)
        case .nw: return offset(by: -1, -1)
        case .x: return self
        }
    }
}

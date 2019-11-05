//
//  Cart.swift
//  aoc
//
//  Created by Paul Uhn on 12/13/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Cart {
    var position: Point
    var direction: Direction
    private var intersection: Direction = .left
    
    init(_ x: Int, _ y: Int, _ direction: Direction) {
        position = Point(x: x, y: y)
        self.direction = direction
    }
    
    func OTID() -> Direction { // one time intersection direction
        let otid = intersection
        
        switch otid {
        case .left: intersection = .none
        case .none: intersection = .right
        case .right: intersection = .left
        default: fatalError()
        }
        return otid.translate(direction)
    }
}
private extension Direction {
    func translate(_ cart: Direction) -> Direction {
        switch (cart, self) {
        case (.up, .left): return .left
        case (.up, .right): return .right
        case (.down, .left): return .right
        case (.down, .right): return .left
        case (.left, .left): return .down
        case (.left, .right): return .up
        case (.right, .left): return .up
        case (.right, .right): return .down
        default: return cart
        }
    }
}

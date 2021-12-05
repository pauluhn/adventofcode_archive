//
//  Vector2.swift
//  aoc
//
//  Created by Paul U on 12/5/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Vector2: Hashable {

    var x: Int { Int(_x.rounded()) }
    var y: Int { Int(_y.rounded()) }

    init(x: Int, y: Int) {
        _x = Double(x)
        _y = Double(y)
    }
    fileprivate init(x: Double, y: Double) {
        _x = x
        _y = y
    }
    fileprivate let _x: Double
    fileprivate let _y: Double

    static let zero = Vector2(x: 0, y: 0)
    static let left = Vector2(x: -1, y: 0)
    static let right = Vector2(x: 1, y: 0)
    static let up = Vector2(x: 0, y: 1)
    static let down = Vector2(x: 0, y: -1)
}

extension Vector2 {

    var magnitude: Double {
        let x2 = _x * _x
        let y2 = _y * _y
        return sqrt(x2 + y2)
    }

    func manhattanDistance(to other: Vector2) -> Int {
        abs(x - other.x) + abs(y - other.y)
    }

    var normalized: Vector2 {
        let m = magnitude
        assert(m > 0)
        return Vector2(x: _x / m, y: _y / m)
    }
}

extension Vector2 {
    static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func * (lhs: Vector2, rhs: Int) -> Vector2 {
        Vector2(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    static func / (lhs: Vector2, rhs: Int) -> Vector2 {
        Vector2(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    static func += (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs + rhs
    }
    static func -= (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs - rhs
    }
}

extension Vector2: CustomStringConvertible {
    var description: String {
        "\(x),\(y)"
    }
}

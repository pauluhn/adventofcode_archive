//
//  Coord.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

public struct Point {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^\\s*(-?\\d+),\\s*(-?\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        x = data.match(match, at: 1).int
        y = data.match(match, at: 2).int
    }
    
    public static let zero = Point(x: 0, y: 0)
    
    func manhattanDistance(from other: Point) -> Int {
        return abs(x - other.x) + abs(y - other.y)
    }
    
    func offset(by x: Int, _ y: Int) -> Point {
        return offset(by: Point(x: x, y: y))
    }
    func offset(by other: Point) -> Point {
        return Point(x: x + other.x, y: y + other.y)
    }
    public static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    public static func - (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    public static func / (lhs: Point, rhs: Int) -> Point {
        return Point(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}
extension Point: Hashable {}
extension Point: CustomStringConvertible {
    public var description: String {
        return "\(x),\(y)"
    }
}
extension Point {
    static func multiplePoints(_ data: String) -> [Point] {
        return x(data) ?? y(data) ?? []
    }
    private static func x(_ data: String) -> [Point]? {
        let regex = try! NSRegularExpression(pattern: "^x=(-?\\d+), y=(\\d+)\\.{2}(\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        var points = [Point]()
        let x = data.match(match, at: 1).int
        let a = data.match(match, at: 2).int
        let b = data.match(match, at: 3).int
        for y in a...b {
            points.append(Point(x: x, y: y))
        }
        return points
    }
    private static func y(_ data: String) -> [Point]? {
        let regex = try! NSRegularExpression(pattern: "^y=(-?\\d+), x=(\\d+)\\.{2}(\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        var points = [Point]()
        let y = data.match(match, at: 1).int
        let a = data.match(match, at: 2).int
        let b = data.match(match, at: 3).int
        for x in a...b {
            points.append(Point(x: x, y: y))
        }
        return points
    }
}

extension Collection where Element == Point {
    func sort(manhattanFrom origin: Point) -> [Point] {
        return self
            .map { ($0, $0.manhattanDistance(from: origin)) }
            .sorted { $0.1 < $1.1 }
            .map { $0.0 }
    }
}

//
//  Point3D.swift
//  aoc
//
//  Created by Paul Uhn on 12/25/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Point3D {
    let x: Int
    let y: Int
    let z: Int
    
    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^\\s*(-?\\d+),\\s*(-?\\d+),\\s*(-?\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        x = data.match(match, at: 1).int
        y = data.match(match, at: 2).int
        z = data.match(match, at: 3).int
    }
    static let zero = Point3D(x: 0, y: 0, z: 0)
    
    func manhattanDistance(from other: Point3D) -> Int {
        return abs(x - other.x) + abs(y - other.y) + abs(z - other.z)
    }
    func offset(by other: Point3D) -> Point3D {
        return Point3D(x: x + other.x, y: y + other.y, z: z + other.z)
    }
    func offset(by distance: Int, toward direction: Direction3D) -> Point3D {
        switch direction {
        case .top: return offset(by: Point3D(x: 0, y: distance, z: 0))
        case .bottom: return offset(by: Point3D(x: 0, y: -distance, z: 0))
        case .left: return offset(by: Point3D(x: -distance, y: 0, z: 0))
        case .right: return offset(by: Point3D(x: distance, y: 0, z: 0))
        case .front: return offset(by: Point3D(x: 0, y: 0, z: distance))
        case .back: return offset(by: Point3D(x: 0, y: 0, z: -distance))
        }
    }
    static func + (lhs: Point3D, rhs: Point3D) -> Point3D {
        return Point3D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    static func - (lhs: Point3D, rhs: Point3D) -> Point3D {
        return Point3D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    static func / (lhs: Point3D, rhs: Int) -> Point3D {
        return Point3D(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }
    static func += (lhs: inout Point3D, rhs: Point3D) {
        lhs = lhs + rhs
    }
}
extension Point3D: Hashable {}
extension Point3D: CustomStringConvertible {
    var description: String {
        return "\(x),\(y),\(z)"
    }
}

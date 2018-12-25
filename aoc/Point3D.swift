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
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^\\s*(-?\\d+),\\s*(-?\\d+),\\s*(-?\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        x = data.match(match, at: 1).int
        y = data.match(match, at: 2).int
        z = data.match(match, at: 3).int
    }
    
    func manhattanDistance(from other: Point3D) -> Int {
        return abs(x - other.x) + abs(y - other.y) + abs(z - other.z)
    }
}
extension Point3D: Hashable {}
extension Point3D: CustomStringConvertible {
    var description: String {
        return "\(x),\(y),\(z)"
    }
}

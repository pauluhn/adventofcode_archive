//
//  Point4D.swift
//  aoc
//
//  Created by Paul Uhn on 12/27/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Point4D {
    let x: Int
    let y: Int
    let z: Int
    let w: Int
    
    init(x: Int, y: Int, z: Int, w: Int) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^\\s*(-?\\d+),\\s*(-?\\d+),\\s*(-?\\d+),\\s*(-?\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        x = data.match(match, at: 1).int
        y = data.match(match, at: 2).int
        z = data.match(match, at: 3).int
        w = data.match(match, at: 4).int
    }
    
    func manhattanDistance(from other: Point4D) -> Int {
        let a = abs(x - other.x)
        let b = abs(y - other.y)
        let c = abs(z - other.z)
        let d = abs(w - other.w)
        return a + b + c + d
    }
    func offset(by other: Point4D) -> Point4D {
        return Point4D(x: x + other.x, y: y + other.y, z: z + other.z, w: w + other.w)
    }
}
extension Point4D: Hashable {}
extension Point4D: CustomStringConvertible {
    var description: String {
        return "\(x),\(y),\(z),\(w)"
    }
}

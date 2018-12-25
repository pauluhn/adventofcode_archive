//
//  2018Day23.swift
//  aoc
//
//  Created by Paul Uhn on 12/25/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation
struct Y2018Day23 {
    static func Part1(_ data: [String]) -> Int {
        let nanobots = data.compactMap(Nanobot.init)
        let strongest = nanobots.sorted { $0.radius < $1.radius }.last!
        let inRange = nanobots
            .filter { strongest.manhattanDistance(from: $0) <= strongest.radius }
        return inRange.count
    }
}
private struct Nanobot {
    let position: Point3D
    let radius: Int
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^pos=<([-\\d,]+)>, r=(\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        position = Point3D(data.match(match, at: 1))!
        radius = data.match(match, at: 2).int
    }
    
    func manhattanDistance(from other: Nanobot) -> Int {
        return position.manhattanDistance(from: other.position)
    }
}

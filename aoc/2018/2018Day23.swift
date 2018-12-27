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
    static func Part2(_ data: [String]) -> Int {
        let nanobots = data.compactMap(Nanobot.init)
        let cloud = nanobots.flatMap { $0.coverage }

        let countedSet = NSCountedSet()
        cloud.forEach { countedSet.add($0) }
        
        let sorted = cloud
            .map { (point: $0, count: countedSet.count(for: $0)) }
            .filter { $0.count > 1 }
            .sorted { $0.count < $1.count }
        let point = sorted.last!.point
        
        return point.manhattanDistance(from: .zero)
    }
}
private struct Nanobot {
    let position: Point3D
    let radius: Int
    
    var coverage: [Point3D] {
        var points = [Point3D]()
        for x in -radius...radius {
            for y in -radius...radius {
                for z in -radius...radius{
                    let offset = Point3D(x: x, y: y, z: z)
                    let point = position.offset(by: offset)
                    if position.manhattanDistance(from: point) <= radius {
                        points.append(point)
                    }
                }
            }
        }
        return points
    }
    
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

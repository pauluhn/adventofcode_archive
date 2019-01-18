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
        let nanobots = Nanobot.generate(data)
        let strongest = nanobots.sorted { $0.radius < $1.radius }.last!
        let inRange = nanobots
            .filter { strongest.manhattanDistance(from: $0) <= strongest.radius }
        return inRange.count
    }
    static func Part2(_ data: [String], _ input: Int) -> Int {
        var nanobots = Nanobot.generate(data)
        
//        let byRadius = nanobots.sorted(by: { $0.radius < $1.radius} )
//        let minRadius = byRadius.first!.radius
//        let maxRadius = byRadius.last!.radius
        // puzzle input compress rate starts at 10_000_000
        
        let compressRate = 1
//        print("compress: \(compressRate)")
        
        nanobots = nanobots.map { $0.compress(by: compressRate) }

        let top = nanobots.max { $0.top.y < $1.top.y }!.top.y
        let bottom = nanobots.min { $0.bottom.y < $1.bottom.y }!.bottom.y
        let left = nanobots.min { $0.left.x < $1.left.x }!.left.x
        let right = nanobots.max { $0.right.x < $1.right.x }!.right.x
        let front = nanobots.max { $0.front.z < $1.front.z }!.front.z
        let back = nanobots.min { $0.back.z < $1.back.z }!.back.z
        
        var box = Octree.Box(min: Point3D(x: left, y: bottom, z: back),
                             max: Point3D(x: right, y: top, z: front))
        var octree = Octree(bounds: box)
        var node = octree.root
        
        switch input {
        // test case
        case 0:
        node = node
            .children.backBottomLeft
            .children.frontTopRight
            .children.frontTopRight
            .children.backBottomLeft
        print(node.box)
        sampling(10, nanobots, node, 100)
            
        // puzzle input
        case 1:
        print(node.box)
            
        // 10_000_000 => 4, 1, 4
        //  1_000_000 => 36, 19, 45
        //    100_000 => 357-358, 194-203, 444-453
        //     10_000 => 3570, 2047, 4431
        //       1000 => 35690, 20483, 44301
        //        100 => 356896, 204843, 443000
        //         10 => 3568964, 2048436, 4430002
        box = Octree.Box(min: Point3D(x: 35689630, y: 20484350, z: 44300010),
                         max: Point3D(x: 35689650, y: 20484370, z: 44300030))
        octree = Octree(bounds: box)
        node = octree.root
        print(node.box)
        
        default: break
        }
        
        // all points
        let countedSet = NSCountedSet()
        for x in node.box.min.x...node.box.max.x {
            for y in node.box.min.y...node.box.max.y {
                for z in node.box.min.z...node.box.max.z {
                    let point = Point3D(x: x, y: y, z: z)
                    for bot in nanobots {
                        if bot.contains(point) {
                            countedSet.add(point)
                        }
                    }
                }
            }
        }
        var results = countedSet
            .map { ($0 as! Point3D, countedSet.count(for: $0)) }
            .sorted { $0.1 > $1.1 }
            .prefix(1000)
//        print(results.prefix(10))
//        print(results.prefix(100))
//        print(results.prefix(1000))
        
        results = results.prefix(10)
//        print("x: \(Set(results.map { $0.0.x }).sorted())")
//        print("y: \(Set(results.map { $0.0.y }).sorted())")
//        print("z: \(Set(results.map { $0.0.z }).sorted())")

        let answer = results.first!.0
        
        return answer.x + answer.y + answer.z
    }
    private static func sampling(_ count: Int, _ nanobots: [Nanobot], _ node: Octree.OctreeNode, _ resolution: Int) {
        for _ in 0..<count {
            var children = Array(repeating: 0, count: 8)
            for bot in nanobots {
                let cloud = bot.coverage(resolution, node.box)
                for (i, child) in node.children.enumerated() {
                    if cloud.first(where: { child.box.contains($0) }) != nil {
                        children[i] += 1
                    }
                }
            }
            let percent = children.map { percentage($0, nanobots.count) }
            print(percent)
        }
    }
    private static func deepSampling(_ count: Int, _ nanobots: [Nanobot], _ node: Octree.OctreeNode, _ resolution: Int) {
        sampling(count, nanobots, node, resolution)
        for (i, child) in node.children.enumerated() {
            print("__for \(node.nodeDescription(i))")
            sampling(count, nanobots, child, resolution)
        }
    }
    private static func percentage(_ numerator: Int, _ denominator: Int) -> Int {
        return Int(Double(numerator) / Double(denominator) * 100)
    }
}
private struct Nanobot {
    let id: Int
    let position: Point3D
    let radius: Int
    
    var top: Point3D { return position.offset(by: radius, toward: .top) }
    var bottom: Point3D { return position.offset(by: radius, toward: .bottom) }
    var left: Point3D { return position.offset(by: radius, toward: .left) }
    var right: Point3D { return position.offset(by: radius, toward: .right) }
    var front: Point3D { return position.offset(by: radius, toward: .front) }
    var back: Point3D { return position.offset(by: radius, toward: .back) }
    
    typealias Box = Octree.Box
    var box: Box { return Box(min: Point3D(x: left.x, y: bottom.y, z: back.z),
                              max: Point3D(x: right.x, y: top.y, z: front.z)) }

    func coverage(_ count: Int, _ box: Box? = nil) -> [Point3D] {
        let box = box ?? self.box
        var cloud = [Point3D]()
        for _ in 0..<count {
            let top = min(self.top.y, box.max.y)
            let bottom = min(self.bottom.y, box.min.y)
            let left = min(self.left.x, box.min.x)
            let right = min(self.right.x, box.max.x)
            let front = min(self.front.z, box.max.z)
            let back = min(self.back.z, box.min.z)
            
            let x = random(left, right)
            let y = random(bottom, top)
            let z = random(back, front)
            
            let point = Point3D(x: x, y: y, z: z)
            if position.manhattanDistance(from: point) <= radius {
                cloud.append(point)
            }
        }
        return cloud
    }

    init?(_ id: Int, _ data: String) {
        let regex = try! NSRegularExpression(pattern: "^pos=<([-\\d,]+)>, r=(\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        self.id = id
        position = Point3D(data.match(match, at: 1))!
        radius = data.match(match, at: 2).int
    }
    private init(_ id: Int, _ position: Point3D, _ radius: Int) {
        self.id = id
        self.position = position
        self.radius = radius
    }
    static func generate(_ data: [String]) -> [Nanobot] {
        var bots = [Nanobot]()
        for (i, d) in data.enumerated() {
            if let bot = Nanobot(i, d) {
                bots.append(bot)
            }
        }
        return bots
    }
    func compress(by rate: Int) -> Nanobot {
        return Nanobot(id, position/rate, radius/rate)
    }
    
    func manhattanDistance(from other: Nanobot) -> Int {
        return position.manhattanDistance(from: other.position)
    }
    func contains(_ point: Point3D) -> Bool {
        return position.manhattanDistance(from: point) <= radius
    }
    
    private func random(_ min: Int, _ max: Int) -> Int {
        return (min...max).randomElement()!
    }
}

//
//  2018Day17.swift
//  aoc
//
//  Created by Paul Uhn on 12/16/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day17 {
    static func Part1(_ data: [String], _ printAfter: Int) -> Int {
        let points = data.flatMap(Point.multiplePoints)
        var (offset, ground) = generateGround(points)
        
        var flows = [Point.spring.offset(by: offset)]
        var direction = [Direction.down]
        var printCount = 0
        
        gameLoop: while true {
            flowLoop: for (f, flow) in flows.enumerated() {
                guard flow.y < ground.count else { break gameLoop }
                guard flows.contains(flow) else { continue flowLoop }
                var flow = flow
                var f = f
                f = flows.firstIndex(of: flow)!

                switch ground[flow.y][flow.x] {
                case .spring:
                    flows[f] = flow.offset(by: 0, 1)
                case .sand:
                    ground[flow.y][flow.x] = .water
                    flows[f] = flow.offset(by: 0, 1)
                case .clay:
                    flows[f] = flow.offset(by: 0, -1)
                    direction[f] = .up
                case .water where direction[f] == .down:
                    flows[f] = flow.offset(by: 0, -1)
                    direction[f] = .up
                    flow = flows[f]
                    fallthrough
                case .water:
                    let (newDirection, leftOffset, rightOffset, remove) = fill(flow, direction[f], &ground)
                    if remove {
                        flows.remove(at: f)
                        continue flowLoop
                    }
                    f = flows.firstIndex(of: flow)!
                    
                    switch newDirection {
                    case .up:
                        flows[f] = flow.offset(by: 0, -1)
                        direction[f] = .up
                    case .left:
                        flows[f] = flow.offset(by: leftOffset, 0)
                        direction[f] = .down
                    case .right:
                        flows[f] = flow.offset(by: rightOffset, 0)
                        direction[f] = .down
                    case .none: // both
                        flows[f] = flow.offset(by: leftOffset, 0)
                        direction[f] = .down
                        flows.append(flow.offset(by: rightOffset, 0))
                        direction.append(.down)
                    default: fatalError()
                    }
                default: fatalError()
                }
            }
            printCount += 1
            if printCount > printAfter {
                printGround(ground)
            }
        }
        printGround(ground)
        return ground.reduce(0) { $0 + $1.reduce(0) { $0 + ($1 == .water ? 1 : 0) }}
    }
}
private extension Y2018Day17 {
    static func generateGround(_ points: [Point]) -> (offset: Point, ground: [[Character]]) {
        var points = points
        points.append(Point.spring)
        
        let xSort = points.sorted { $0.x < $1.x }
        let ySort = points.sorted { $0.y < $1.y }
        let minX = xSort.first!.x - 1
        let maxX = xSort.last!.x + 1
        let minY = ySort.first!.y
        let maxY = ySort.last!.y
        let xOffset = -minX
        let yOffset = -minY

        var ground = Array(repeating: Array(repeating: Character.sand, count: maxX + xOffset + 1), count: maxY + yOffset + 1)
        for point in points {
            ground[point.y + yOffset][point.x + xOffset] = .clay
        }
        ground[Point.spring.y + yOffset][Point.spring.x + xOffset] = .spring
        
        return (Point(x: xOffset, y: yOffset), ground)
    }
    static func printGround(_ ground: [[Character]]) {
        let prefix = 75
        let ground = ground.map { $0.prefix(prefix) }
        
        let display = ground.reduce("") { $0 + $1.reduce("") { $0 + String($1) } + "\n" }
        print(display)
    }
    static func fill(_ point: Point, _ direction: Direction, _ ground: inout [[Character]]) -> (direction: Direction, leftOffset: Int, rightOffset: Int, remove: Bool) {
        // left
        var x = point.x - 1
        let y = point.y
        var l1 = 0
        var l2 = 0
        while canFill(x, y, ground) {
            l1 += 1
            if ground[y][x] == .water {
                l2 += 1
            }
            ground[y][x] = .water
            x -= 1
        }
        let left = canSpill(x, y, ground)
        let leftOffset = x - point.x
        
        // right
        x = point.x + 1
        var r1 = 0
        var r2 = 0
        while canFill(x, y, ground) {
            r1 += 1
            if ground[y][x] == .water {
                r2 += 1
            }
            ground[y][x] = .water
            x += 1
        }
        let right = canSpill(x, y, ground)
        let rightOffset = x - point.x
        
        let newDirection = { (left, right) -> Direction in
            switch (left, right) {
            case (true, true): return .none // both
            case (false, false): return .up
            case (true, false): return .left
            case (false, true): return .right
            }
        }(left, right)
        
        var remove = false
        if l2 > 0 || r2 > 0 {
            remove = true
        }
        
        return (newDirection, leftOffset, rightOffset, remove)
    }
    static func canFill(_ x: Int, _ y: Int, _ ground: [[Character]]) -> Bool {
        switch (ground[y][x], ground[y + 1][x]) {
        case (.water, .water),
             (.sand, .water),
             (.sand, .clay): return true
        default: return false
        }
    }
    static func canSpill(_ x: Int, _ y: Int, _ ground: [[Character]]) -> Bool {
        guard x >= 0, x < ground[0].count else { return false }
        switch ground[y][x] {
        case .clay, .water: return false
        default: return true
        }
    }
}
private extension Character {
    static let spring: Character = "+"
    static let sand: Character = "."
    static let clay: Character = "#"
    static let water: Character = "|"
    
//    var isSpring: Bool { return self == Character.spring }
//    var isSand: Bool { return self == Character.sand }
//    var isClay: Bool { return self == Character.clay }
//    var isWater: Bool { return self == Character.water }
}
private extension Point {
    static let spring = Point(x: 500, y: 0)
}

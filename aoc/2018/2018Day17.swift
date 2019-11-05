//
//  2018Day17.swift
//  aoc
//
//  Created by Paul Uhn on 12/16/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day17 {
    static func Part0(_ data: [String], _ printAfter: Int) -> (score: (flow: Int, pool: Int), round: Int) {
        let points = data.flatMap(Point.multiplePoints)
        var (ground, flow) = generateGround(points)
        
        var flows: [Flow] = [flow]
        var block = Set<Point>()
        var round = 0
        
        gameLoop: while true {
            flowLoop: for flow in flows {
                guard flow.y < ground.count else { break gameLoop }
                guard flows.contains(flow) else { continue flowLoop }
                
                switch ground[flow.y][flow.x] {
                case .spring:
                    flow.offset(by: 0, 1)
                    
                case .sand:
                    checkBlocking(flow, ground, &block)
                    ground[flow.y][flow.x] = .flow
                    flow.offset(by: 0, 1)
                    
                case .clay:
                    fallthrough
                    
                case .pool:
                    flow.offset(by: 0, -1)
                    fallthrough

                case .flow:
                    let (direction, lhs, rhs) = fill(flow.location, &ground)
                    
                    func computeFlow(_ first: Point?, _ second: Point? = nil) {
                        let points = [first, second].compactMap { $0 }
                        let good = points.filter { !block.contains($0) }
                        points.forEach { block.insert($0) }

                        switch good.count {
                        case 0:
                            flows.removeAll { $0 == flow }
                        case 2:
                            flows.append(.init(good[1]))
                            fallthrough
                        case 1:
                            flow.location = good[0]
                        default: fatalError()
                        }
                    }
                    
                    switch direction {
                    case .up:
                        flow.offset(by: 0, -1)
                        
                    case .left:
                        computeFlow(flow.location.offset(by: lhs - 1, 0))

                    case .right:
                        computeFlow(flow.location.offset(by: rhs + 1, 0))
                        
                    case .down: // both sides
                        let first = flow.location.offset(by: lhs - 1, 0)
                        let second = flow.location.offset(by: rhs + 1, 0)
                        computeFlow(first, second)

                    default: fatalError()
                    }
                default: fatalError()
                }
            }
            round += 1
            if round > printAfter {
                printGround(ground)
            }
        }
        let score = ground.reduce((0, 0)) {
            let water = $1.reduce((0, 0)) {
                let flow = $1.isFlow ? 1 : 0
                let pool = $1.isPool ? 1 : 0
                return ($0.0 + flow, $0.1 + pool)
            }
            return ($0.0 + water.0, $0.1 + water.1)
        }
        return (score, round)
    }
    static func Part1(_ data: [String], _ printAfter: Int) -> (score: Int, round: Int) {
        let tuple = Part0(data, printAfter)
        let score = tuple.score.flow + tuple.score.pool
        return (score, tuple.round)
    }
    static func Part2(_ data: [String], _ printAfter: Int) -> Int {
        return Part0(data, printAfter).score.pool
    }
}
private class Flow: Equatable {
    var location: Point
    var x: Int { return location.x }
    var y: Int { return location.y }
    init(_ point: Point) { location = point }
    static func == (lhs: Flow, rhs: Flow) -> Bool {
        return lhs.location ==  rhs.location
    }
    func offset(by x: Int, _ y: Int) {
        location = location.offset(by: x, y)
    }
}
private extension Y2018Day17 {
    static func generateGround(_ points: [Point]) -> (ground: [[Character]], flow: Flow) {
        let xValues = points.sorted { $0.x < $1.x }
        let yValues = points.sorted { $0.y < $1.y }
        let minX = xValues.first!.x - 1
        let maxX = xValues.last!.x + 1
        let minY = yValues.first!.y
        let maxY = yValues.last!.y
        let xOffset = -minX
        let yOffset = -minY

        var ground: [[Character]] = Array(repeating: Array(repeating: .sand, count: maxX + xOffset + 1), count: maxY + yOffset + 2)
        for point in points {
            ground[point.y + yOffset + 1][point.x + xOffset] = .clay
        }
        
        let spring = Point(x: Point.spring.x + xOffset, y: Point.spring.y)
        ground[spring.y][spring.x] = .spring
        
        return (ground, Flow(spring))
    }
    static func printGround(_ ground: [[Character]]) {
        let display = ground.reduce("") { $0 + $1.reduce("") { $0 + String($1) } + "\n" }
        print(display)
    }
    static func fill(_ point: Point, _ ground: inout [[Character]]) -> (direction: Direction, leftOffset: Int, rightOffset: Int) {
        // left
        var x = point.x - 1
        let y = point.y
        while canFill(x, y, ground) { x -= 1 }
        let lhs = canSpill(x, y, ground)
        let left = x - point.x + 1
        
        // right
        x = point.x + 1
        while canFill(x, y, ground) { x += 1 }
        let rhs = canSpill(x, y, ground)
        let right = x - point.x - 1
        
        let direction = { (lhs, rhs) -> Direction in
            switch (lhs, rhs) {
            case (true, true): return .down // both sides
            case (false, false): return .up
            case (true, false): return .left
            case (false, true): return .right
            }
        }(lhs, rhs)
        
        let c = { direction -> Character in
            switch direction {
            case .up: return .pool
            case .left, .right, .down: return .flow
            default: fatalError()
            }
        }(direction)
        
        for x in (point.x + left)...(point.x + right) {
            ground[y][x] = c
        }

        return (direction, left, right)
    }
    private static func canFill(_ x: Int, _ y: Int, _ ground: [[Character]]) -> Bool {
        return ground[y][x].canFlow && ground[y + 1][x].canBlock
    }
    private static func canSpill(_ x: Int, _ y: Int, _ ground: [[Character]]) -> Bool {
        guard x >= 0, x < ground[0].count else { return false }
        return !ground[y][x].canBlock
    }
    private static func existingFlow(_ x: Int, _ y: Int, _ ground: [[Character]]) -> Bool {
        return ground[y][x].isFlow && ground[y + 1][x].isFlow
    }
    static func checkBlocking(_ flow: Flow, _ ground: [[Character]], _ block: inout Set<Point>) {
        let x = flow.x
        let y = flow.y
        guard ground[y][x] == .sand else { return }
        guard x > 0, x < ground[0].count - 1, y < ground.count - 1 else { return }
        let left = ground[y + 1][x - 1]
        let middle = ground[y + 1][x]
        let right = ground[y + 1][x + 1]
        switch (left, middle, right) {
        case (.clay, .sand, _), (_, .sand, .clay): break
        default: return
        }
        block.insert(flow.location)
    }
}
private extension Character {
    static let spring: Character = "+"
    static let sand: Character = "."
    static let clay: Character = "#"
    static let flow: Character = "|"
    static let pool: Character = "~"
    
    var isFlow: Bool {
        return self == .flow
    }
    var isPool: Bool {
        return self == .pool
    }
    var canFlow: Bool {
        return self == .sand || self == .flow
    }
    var canBlock: Bool {
        return self == .clay || self == .pool
    }
}
private extension Point {
    static let spring = Point(x: 500, y: 0)
}

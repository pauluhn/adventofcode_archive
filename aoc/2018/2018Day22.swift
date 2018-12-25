//
//  2018Day22.swift
//  aoc
//
//  Created by Paul Uhn on 12/24/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day22 {
    fileprivate typealias Node = Graph<PointTool>.GraphNode<PointTool>
    static func Part1(_ depth: Int, _ x: Int, _ y: Int) -> Int {
        let cave = computeCave(depth, x, y)
        printCave(cave)
        return riskLevel(cave)
    }
    static func Part2(_ depth: Int, _ x: Int, _ y: Int) -> Double {
        let mouth = Point(x: 0, y: 0)
        let target = Point(x: x, y: y)
        let padding = 100
        let cave = computeCave(depth, x, y, padding)
        printCave(cave)
        let graph = Graph.generateMap(cave, mouth, target)
        print(graph)
        
        var unvisited = Set(graph.nodes)
        var data = graph.nodes.reduce(into: [Node: Double]()) { $0[$1] = Double.greatestFiniteMagnitude }
        
        var node = graph.nodes.first { $0.value == PointTool(mouth, .torch) }!
        data[node] = 0
        
        while node.value.point != target {
            let neighbors = graph.links(node).map { (node: $0.to, weight: $0.weight ?? 0) }
            let visit = neighbors.filter { unvisited.contains($0.node) }
            let current = data[node]!
            visit.forEach {
                data[$0.node] = min(data[$0.node]!, $0.weight + current)
                
            }
            unvisited.remove(node)

            node = unvisited
                .map { (node: $0, weight: data[$0]!) }
                .sorted { $0.weight < $1.weight }
                .first
                .map { $0.node }!
        }
        return data[node]!
    }
}
private struct Region {
    let depth: Int
    let geologicIndex: Int
    let erosionLevel: Int
    enum RegionType: Int {
        case rocky
        case wet
        case narrow
        case mouth
        case target
    }
    let type: RegionType
    let special: RegionType?
    init(_ depth: Int, _ geologicIndex: Int) {
        self.depth = depth
        self.geologicIndex = geologicIndex
        erosionLevel = (geologicIndex + depth) % 20183
        type = RegionType(rawValue: erosionLevel % 3)!
        special = nil
    }
    init(_ depth: Int, _ special: RegionType) {
        self.depth = depth
        geologicIndex = 0
        erosionLevel = (geologicIndex + depth) % 20183
        type = RegionType(rawValue: erosionLevel % 3)!
        self.special = special
    }
}
private enum Time {
    static let move = 1.0
    static let keep = 0.0
    static let `switch` = 7.0
}
private enum Tool: String {
    case torch = "🔥"
    case climbingGear = "⛏️"
    case neither = "🇽"
}
private struct PointTool: Hashable {
    let x: Int
    let y: Int
    let tool: Tool
    init(_ point: Point, _ tool: Tool) {
        x = point.x
        y = point.y
        self.tool = tool
    }
    var point: Point { return Point(x: x, y: y) }
}
extension PointTool: CustomStringConvertible {
    var description: String {
        return "\(x),\(y):(\(tool.rawValue))"
    }
}
private extension Y2018Day22 {
    static func computeCave(_ depth: Int, _ targetX: Int, _ targetY: Int, _ padding: Int = 0) -> [[Region]] {
        var cave = [[Region]]()
        for y in 0..<targetY + padding + 1 {
            cave.append([])
            for x in 0..<targetX + padding + 1 {
                switch (x, y) {
                case (0, 0):
                    cave[y].append(Region(depth, .mouth))
                case (targetX, targetY):
                    cave[y].append(Region(depth, .target))
                case (0, _):
                    cave[y].append(Region(depth, y * 48271))
                case (_, 0):
                    cave[y].append(Region(depth, x * 16807))
                default:
                    let geologicIndex = cave[y][x - 1].erosionLevel * cave[y - 1][x].erosionLevel
                    cave[y].append(Region(depth, geologicIndex))
                }
            }
        }
        return cave
    }
    static func printCave(_ cave: [[Region]]) {
        let display = cave.reduce("") { $0 + $1.reduce("") { "\($0)\($1)" } + "\n" }
        print(display)
    }
    static func riskLevel(_ cave: [[Region]]) -> Int {
        return cave.reduce(0) { $0 + $1.reduce(0) { $0 + $1.type.rawValue }}
    }
}
extension Region: CustomStringConvertible {
    var description: String {
        return special?.description ?? type.description
    }
}
extension Region.RegionType: CustomStringConvertible {
    var description: String {
        switch self {
        case .rocky: return "."
        case .wet: return "="
        case .narrow: return "|"
        case .mouth: return "M"
        case .target: return "T"
        }
    }
}
private extension Graph where T == PointTool {
    static func generateMap(_ data: [[Region]], _ mouth: Point, _ target: Point) -> Graph {
        let graph = Graph<PointTool>()
        for y in 0..<data.count {
            for x in 0..<data[0].count {
                graph.link(data, x, y, mouth, target)
            }
        }
        return graph
    }
    private func link(_ data: [[Region]], _ x: Int, _ y: Int, _ mouth: Point, _ target: Point) {
        let point = Point(x: x, y: y)
        let tools = data[y][x].tools
        let nodes = tools.map { create(.init(point, $0)) }
        
        let directions: [Direction] = [.up, .left]
        let others = directions.flatMap { self.nodes($0, of: point) }
        
        for node in nodes {
            otherLoop: for other in others {
                let penalty = node.tool == other.tool ? Time.keep : Time.switch
                let weight = Time.move + penalty
                // mouth
                if other.value.point == mouth {
                    link(other, to: node, weight: weight)
                    continue otherLoop
                }
                // target
                if node.value.point == target {
                    link(other, to: node, weight: weight)
                    continue otherLoop
                }
                if other.value.point == target {
                    link(node, to: other, weight: weight)
                    continue otherLoop
                }
                // regular
                link(node, to: other, weight: weight)
                link(other, to: node, weight: weight)
            }
        }
    }
    private func nodes(_ direction: Direction, of point: Point) -> [Node] {
        let offset = point.offset(by: direction.offset)
        return nodes.filter { $0.value.x == offset.x && $0.value.y == offset.y }
    }
}
private extension Graph.GraphNode where T == PointTool {
    var tool: Tool { return value.tool }
}
private extension Region {
    var tools: [Tool] {
        guard let special = special else {
            return list(for: type)
        }
        return list(for: special)
    }
    private func list(for type: RegionType) -> [Tool] {
        switch type {
        case .rocky: return [.climbingGear, .torch]
        case .wet: return [.climbingGear, .neither]
        case .narrow: return [.torch, .neither]
        case .mouth: return [.torch]
        case .target: return [.torch]
        }
    }
}

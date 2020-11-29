//
//  2019Day20.swift
//  aoc
//
//  Created by Paul U on 11/21/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2019Day20 {

    enum Tile {
        case space
        case wall       // #
        case passage    // .
        case label(Character)
    }
    
    struct Portal {
        enum DirectionType {
            /// label first, then passage
            case forward
            case backward
        }
        enum State {
            case incomplete
            case complete
        }
        let direction: DirectionType
        private(set) var state: State
        private(set) var label: String
        private(set) var labelPoints: [Point]
        private(set) var portalPoints: [Point]
    }
        
    static func Part1(_ data: [String]) -> Int {
        let map = data.map { $0.map { c -> Tile in
            switch c {
            case " ": return .space
            case "#": return .wall
            case ".": return .passage
            default:  return .label(c)
            }
        }}
        
        let graph = Graph<Point>()
        let portals = PortalManager()

        for (y, row) in map.enumerated() {
            for (x, tile) in row.enumerated() {
                let point = Point(x: x, y: y)
                
                switch tile {
                case .space, .wall: break
                case .passage:
                    let node = graph.create(point)
                    graph.addNeighbors(node)
                    
                case .label(let c):
                    portals.addLabel(c, point)
                }
            }
        }
        // Add portals
        let points = graph.nodes.map { $0.value }
        let warp = portals.portals().flatMap { p -> [Point] in
            let warp = p.filter { points.contains($0) }
            guard warp.count == 2 else { return [] }
            return warp
        }
        for i in 0 ..< (warp.count / 2) {
            let first = graph.create(warp[i * 2])
            let second = graph.create(warp[i * 2 + 1])
            graph.link(first, to: second)
            graph.link(second, to: first)
        }
        let start = portals.start.first { points.contains($0) }
        let end = portals.end.first { points.contains($0) }
        let path = a_star(graph, start!, end!)
        return path.count - 1
    }
    
    private static func a_star(_ graph: Graph<Point>, _ start: Point, _ goal: Point) -> [Point] {
        var open = Set([start])
        var previous = [Point: Point]()
        // g = from start
        var g = graph.data(initial: Int.max)
        g[start] = 0
        // f = known + h
        var f = graph.data(initial: Int.max)
        f[start] = start.manhattanDistance(from: goal)
        
        var current = Point.zero
        while !open.isEmpty {
            current = open
                .map { ($0, f[$0]!) }
                .sorted { $0.1 < $1.1 }
                .first!.0
            if current == goal {
                break
            }
            open.remove(current)
            
            let node = graph.nodes.first { $0.value == current }!
            let neighbors = graph.links(node).map { $0.to.value }
            for neighbor in neighbors {
                if g[current]! < g[neighbor]! {
                    previous[neighbor] = current
                    g[neighbor] = g[current]
                    f[neighbor] = g[neighbor]!// + neighbor.manhattanDistance(from: goal)
                    if !open.contains(neighbor) {
                        open.insert(neighbor)
                    }
                }
            }
        }
        // reconstruct
        var path = [current]
        while let next = previous[current] {
            current = next
            path.prepend(current)
        }
        return path
    }
}

private extension Y2019Day20 {
    class PortalManager {
        private var chars = [Point: Character]()
        private var labels = [String: [Point]]()
        var start: [Point] { return portal("AA") }
        var end: [Point] { return portal("ZZ") }
        
        func addLabel(_ c: Character, _ p: Point) {
            chars[p] = c
            if let point = neighbor(p), let char = chars[point] {
                let label = "\(char)\(c)"
                if labels[label] == nil { labels[label] = [] }
                labels[label]?.append(contentsOf: portals(point, p))
            }
        }
        func portals() -> [[Point]] {
            return labels
                .filter { $0.value.count == 4 }
                .map { $0.value }
        }
        private func neighbor(_ point: Point) -> Point? {
            let neighbors = point.neighbors
            return chars.keys
                .filter { neighbors.contains($0) }
                .first
        }
        private func portals(_ p1: Point, _ p2: Point) -> [Point] {
            if p1 == p2.up {
                return [p1.up, p2 + Direction.down.offset]
            } else if p1 == p2.left {
                return [p1.left, p2 + Direction.right.offset]
            } else {
                fatalError()
            }
        }
        private func portal(_ label: String) -> [Point] {
            return labels
                .first { $0.key == label }
                .map { $0.value } ?? []
        }
    }
}
private extension Graph where T == Point {
    func addNeighbors(_ node: Node) {
        let neighbors = node.value.neighbors
        nodes
            .filter { neighbors.contains($0.value) }
            .forEach {
                link(node, to: $0)
                link($0, to: node)
            }
    }
}
private extension Graph.GraphNode where T == Point {
    
}
private extension Point {
    var neighbors: [Point] { return [self.up, self.left] }
    var up: Point { self + Direction.up.offset }
    var left: Point { self + Direction.left.offset }
}

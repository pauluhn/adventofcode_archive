//
//  2018Day20.swift
//  aoc
//
//  Created by Paul Uhn on 12/20/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day20 {
    typealias Node = Graph<Point>.GraphNode<Point>
    fileprivate enum Value {
        case begin // ^
        case end // $
        case north
        case south
        case west
        case east
        case open // begin branches
        case close // end branches
        case delimiter // next branch
    }
    static func Part0(_ data: String) -> Graph<Point> {
        let graph = Graph<Point>()
        var previous: Node!
        var branches = [Node]()
        
        for d in data {
            switch d.value {
            case .begin:
                let point = Point(x: 0, y: 0)
                let node = graph.create(point)
                previous = node
                
            case .end:
                break
                
            case .north:
                let point = previous.value.offset(by: 0, 1)
                let node = graph.create(point)
                graph.link(previous, to: node, weight: d.value.weight)
                previous = node
                
            case .south:
                let point = previous.value.offset(by: 0, -1)
                let node = graph.create(point)
                graph.link(previous, to: node, weight: d.value.weight)
                previous = node

            case .west:
                let point = previous.value.offset(by: -1, 0)
                let node = graph.create(point)
                graph.link(previous, to: node, weight: d.value.weight)
                previous = node

            case .east:
                let point = previous.value.offset(by: 1, 0)
                let node = graph.create(point)
                graph.link(previous, to: node, weight: d.value.weight)
                previous = node

            case .open:
                branches.append(previous)
                
            case .close:
                branches.removeLast()
                
            case .delimiter:
                previous = branches.last!
            }
        }
//        print(graph.description)
        return graph
    }
    static func Part1(_ data: String) -> Int {
        return Part0(data).heaviest
    }
    static func Part2(_ data: String) -> Int {
        let graph = Part0(data)
        return graph.nodes.reversed()
            .map { graph.computeWeight($0) }
            .filter { $0 >= 1000 }
            .count
    }
}
private extension Character {
    var value: Y2018Day20.Value {
        switch self {
        case "^": return .begin
        case "$": return .end
        case "N": return .north
        case "S": return .south
        case "W": return .west
        case "E": return .east
        case "(": return .open
        case ")": return .close
        case "|": return .delimiter
        default: fatalError()
        }
    }
}
private extension Y2018Day20.Value {
    var weight: Double {
        switch self {
        case .begin: return 0
        case .end: fatalError()
        case .north: return 1
        case .south: return 2
        case .west: return 3
        case .east: return 4
        case .open: fatalError()
        case .close: fatalError()
        case .delimiter: fatalError()

        }
    }
}
private extension Graph where T == Point {
    var heaviest: Int {
        var memo = [Node: Int]()
        
        for node in nodes.reversed() {
            let last = links(node).compactMap { memo[$0.to] }.sorted().last
            if let weight = last {
                memo[node] = weight + 1
            } else {
                memo[node] = 1
            }
        }
        return memo[nodes.first!]! - 1
    }
    func computeWeight(_ node: Node) -> Int {
        var memo = [Node: Int]()
        
        for n in nodes.reversed() {
            if n == node {
                memo[n] = 1
                continue
            }
            let last = links(n).compactMap { memo[$0.to] }.sorted().last
            if let weight = last {
                memo[n] = weight + 1
            }
        }
        if let first = memo[nodes.first!] {
            return first - 1
        } else {
            return 0
        }
    }
}

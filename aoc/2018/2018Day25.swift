//
//  2018Day25.swift
//  aoc
//
//  Created by Paul Uhn on 12/27/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day25 {
    fileprivate typealias Node = Graph<Point4D>.GraphNode<Point4D>
    
    static func Part1(_ data: [String]) -> Int {
        let points = data.compactMap(Point4D.init)
        let graph = Graph.generate(points)
        print(graph)
        
        var set = Set<Set<Node>>()
        for node in graph.nodes {
            var constellation = Set<Node>([node])
            var links = graph.links(node).map { $0.to }
            while !links.isEmpty {
                links.forEach { constellation.insert($0) }
                links = links
                    .flatMap { graph.links($0).map { $0.to }}
                    .filter { !constellation.contains($0) }
            }
            set.insert(constellation)
        }
        return set.count
    }
}
private extension Graph where T == Point4D {
    static func generate(_ data: [Point4D]) -> Graph {
        let graph = Graph<Point4D>()
        let nodes = data.map(graph.create)
        
        var block = [Node]()
        for node in nodes {
            let next = nodes.filter {
                guard !block.contains($0) else { return false }
                let distance = $0.manhattanDistance(from: node)
                return distance > 0 && distance <= 3
            }
            next.forEach {
                graph.link(node, to: $0)
                graph.link($0, to: node)
            }
            block.append(node)
        }
        return graph
    }
}
private extension Graph.GraphNode where T == Point4D {
    func manhattanDistance(from node: Y2018Day25.Node) -> Int {
        return value.manhattanDistance(from: node.value)
    }
}

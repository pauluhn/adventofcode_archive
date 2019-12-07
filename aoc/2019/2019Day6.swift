//
//  2019Day6.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day6 {
    typealias Node = Graph<String>.GraphNode<String>
    
    static func Part1(_ data: [String]) -> Int {
        let graph = Graph<String>().generate(data)

        // start from COM
        let com = graph.nodes.first { $0.value == "COM" }!
        return graph.sumOrbits(from: com, level: 0)
    }
    
    static func Part2(_ data: [String]) -> Int {
        let graph = Graph<String>().generate(data, bidirectional: true)

        // start from YOU
        let you = graph.nodes.first { $0.value == "YOU" }!
        let san = graph.nodes.first { $0.value == "SAN" }!
    
        var toVisit = [you]
        var visited = Set<Node>()
        var hops = [-1]
        
        while !toVisit.isEmpty {
            let visit = toVisit.removeFirst()
            let hop = hops.removeFirst()
            guard !visited.contains(visit) else { continue }
            visited.insert(visit)
            
            let next = graph.links(visit).map { $0.to }
            if next.contains(san) { return hop }
            
            toVisit.append(contentsOf: next)
            hops.append(contentsOf:
                Array(repeating: hop + 1, count: next.count))
        }
        return 0
    }
}

private extension Graph where T == String {
    func generate(_ data: [String], bidirectional: Bool = false) -> Graph {
        let nodeData = data.map {
            $0.split(separator: ")").map(String.init)
        }

        let graph = Graph<String>()
        for d in nodeData where d.count == 2 {
            let first = graph.create(d.first!)
            let second = graph.create(d.last!)
            graph.link(first, to: second, weight: 1)
            if bidirectional {
                graph.link(second, to: first, weight: 1)
            }
        }
        return graph
    }
    func sumOrbits(from node: Node, level: Int) -> Int {
        return level + links(node)
            .map { sumOrbits(from: $0.to, level: level + 1) }
            .reduce(0, +)
    }
}

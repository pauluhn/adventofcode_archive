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
        let nodeData = data.map {
            $0.split(separator: ")").map(String.init)
        }

        let graph = Graph<String>()
        for d in nodeData where d.count == 2 {
            let first = graph.create(d.first!)
            let second = graph.create(d.last!)
            graph.link(first, to: second, weight: 1)
        }
        
        // start from COM
        let com = graph.nodes.first { $0.value == "COM" }!
        return graph.sumOrbits(from: com, level: 0)
    }
}

private extension Graph where T == String {
    func sumOrbits(from node: Node, level: Int) -> Int {
        return level + links(node)
            .map { sumOrbits(from: $0.to, level: level + 1) }
            .reduce(0, +)
    }
}

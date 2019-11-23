//
//  2017Day12.swift
//  aoc
//
//  Created by Paul Uhn on 11/19/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day12 {
    
    struct Pipe {
        let input: Int
        private(set) var outputs: [Int]
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^(\\d+) <-> ([\\d, ]+)")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
            input = data.match(match, at: 1).int
            outputs = data.match(match, at: 2)
                .split(separator: ",")
                .map(String.init)
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .map { $0.int }
        }
        
        mutating func reset() {
            outputs = []
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        let pipes = data.compactMap(Pipe.init)
        return group(pipes, with: 0).count
    }
    
    static func Part2(_ data: [String]) -> Int {
        var pipes = data.compactMap(Pipe.init)
        var groups = 0
        
        for i in 0..<pipes.count where !pipes[i].outputs.isEmpty {
            let g = group(pipes, with: pipes[i].input)
            g.forEach {
                pipes[$0].reset()
            }
            groups += 1
        }
        return groups
    }
    
    private static func group(_ pipes: [Pipe], with programID: Int) -> Set<Int> {
        var nodes = [programID]
        var set = Set<Int>()
        
        while !nodes.isEmpty {
            let node = nodes.removeFirst()
            if set.contains(node) {
                continue
            }
            set.insert(node)
            
            nodes.append(contentsOf: pipes[node].outputs)
        }
        return set
    }
}

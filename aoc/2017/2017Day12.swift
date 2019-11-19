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
        let outputs: [Int]
        
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
    }
    
    static func Part1(_ data: [String]) -> Int {
        let pipes = data.compactMap(Pipe.init)
        
        var nodes = [0]
        var set = Set<Int>()
        
        while !nodes.isEmpty {
            let node = nodes.removeFirst()
            if set.contains(node) {
                continue
            }
            set.insert(node)
            
            nodes.append(contentsOf: pipes[node].outputs)
        }
        
        return set.count
    }
}

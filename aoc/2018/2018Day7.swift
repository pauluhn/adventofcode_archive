//
//  2018Day7.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day7 {
    static func Part1(_ data: [String]) -> String {
        assert(Instruction("Step C must be finished before step A can begin.")!.description == "Step C must be finished before step A can begin.")
        
        let nodes = allNodes(data)
        
        var used = [String]()
        while used.count < nodes.count {
            let ready = nodes
                .filter { $0.prerequisites(used) && !used.contains($0.id) }
                .sorted { $0.id < $1.id }
                .first!
            used.append(ready.id)
        }
        return used.reduce("", +)
    }
    static func Part2(_ data: [String], _ baseTime: Int, _ workers: Int) -> Int {
        var nodes = allNodes(data)
        let nodeCount = nodes.count
        
        var elves = (0..<workers).map { _ in Worker(baseTime: baseTime) }
        var used = [String]()
        var tickTock = 0
        while used.count < nodeCount {
            // work
            let ready = nodes
                .filter({ $0.prerequisites(used) && !used.contains($0.id) })
                .sorted(by: { $0.id < $1.id })
            for node in ready {
                if let worker = elves.firstIndex(where: { $0.state == .available }) {
                    nodes.remove(node)
                    elves[worker].work(on: node.id)
                }
            }
            
            // time
            tickTock += 1
            for i in 0..<workers {
                elves[i].tickTock()
            }
            
            // done
            for i in 0..<workers {
                if elves[i].state == .done {
                    used.append(elves[i].ackWorkDone())
                }
            }
        }
        return tickTock
    }
}
private extension Y2018Day7 {
    static func allNodes(_ data: [String]) -> Set<Node> {
        let lines = data.compactMap(Instruction.init)
        
        var nodes = Set<Node>()
        for line in lines {
            let parent = nodes.find(id: line.parent) ?? Node(id: line.parent)
            let child = nodes.find(id: line.child) ?? Node(id: line.child)
            parent.add(child: child)
            child.add(parent: parent)
            nodes.update(with: parent)
            nodes.update(with: child)
        }
        return nodes
    }
}
private extension Node {
    func prerequisites(_ parents: [String]) -> Bool {
        let need = Set(self.parents.map { $0.id })
        let done = Set(parents)
        return need.subtracting(done).isEmpty
    }
}

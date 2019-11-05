//
//  2018Day12.swift
//  aoc
//
//  Created by Paul Uhn on 12/12/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day12 {
    static func Part1(_ data: [String], _ generations: Int) -> Int {
//        var timer = Date()
        assert(initialState("initial state: #..#.#..##......###...###").array == [true, false, false, true, false, true, false, false, true, true, false, false, false, false, false, false, true, true, true, false, false, false, true, true, true])
        
        var data = data
        let pots = initialState(data.removeFirst()).list
        assert(data.removeFirst().isEmpty)
        let notes = buildNotes(data)
        
        var offset = -5
        pots.insert([false, false, false, false, false], at: 0)
        pots.append([false, false, false, false, false])
//        print("pre:\(timer.timeIntervalSinceNow)");timer = Date()
        
        for _ in 0..<generations {
//            print("g:\(g)")
            var cache = [Int: Bool]()
            
            for i in 0..<pots.count-5 {
                var pattern = [true]
                pattern.append(contentsOf: pots[i..<i+5])
                cache[i + 2] = notes.search(for: pattern) ?? false
            }
//            print("cached:\(timer.timeIntervalSinceNow)");timer = Date()

            // copy cache to pots
            for (k, v) in cache {
                pots.node(at: k).value = v
            }
//            print("copied:\(timer.timeIntervalSinceNow)");timer = Date()

            // adjust
            for pot in pots[0..<5] where pot {
                offset -= 1
                pots.insert(false, at: 0)
            }
            for pot in pots[pots.count-5..<pots.count] where pot {
                pots.append(false)
            }
//            print("adjusted:\(timer.timeIntervalSinceNow)");timer = Date()
        }
        
        var sum = 0
        for (i, pot) in pots[0..<pots.count].enumerated() where pot {
            sum += i + offset
        }
        return sum
    }
    static func Part2(_ data: [String], _ generations: Int) -> Int {
        var data = data
        let pots = initialState(data.removeFirst()).list
        assert(data.removeFirst().isEmpty)
        let notes = buildNotes(data)
        
        var offset = -5
        pots.insert([false, false, false, false, false], at: 0)
        pots.append([false, false, false, false, false])
        
        var previousSum = 0
        var sumDiff: (diff: Int, times: Int, g: Int, sum: Int) = (0, 0, 0, 0)
        for g in 0..<generations {
            var cache = [Int: Bool]()
            
            for i in 0..<pots.count-5 {
                var pattern = [true]
                pattern.append(contentsOf: pots[i..<i+5])
                cache[i + 2] = notes.search(for: pattern) ?? false
            }
            
            for (k, v) in cache {
                pots.node(at: k).value = v
            }

            for pot in pots[0..<5] where pot {
                offset -= 1
                pots.insert(false, at: 0)
            }
            for pot in pots[pots.count-5..<pots.count] where pot {
                pots.append(false)
            }
            
            // magic
            var sum = 0
            for (i, pot) in pots[0..<pots.count].enumerated() where pot {
                sum += i + offset
            }
            sumDiff.g = g
            sumDiff.sum = sum
            if sum - previousSum == sumDiff.diff {
                sumDiff.times += 1
                if sumDiff.times > 10 { break }
            } else {
                sumDiff = (sum - previousSum, 0, g, sum)
            }
//            print("\(g):\(sum - previousSum)")
            previousSum = sum
        }
        return sumDiff.sum + (generations - sumDiff.g - 1) * sumDiff.diff
    }
}
private extension Y2018Day12 {
    static func initialState(_ data: String) -> (array: [Bool], list: LinkedList<Bool>) {
        let regex = try! NSRegularExpression(pattern: "^initial state: ([#\\.]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { fatalError() }
        
        let nodes = data
            .match(match, at: 1)
            .map { $0 == "#" ? true : false }

        let list = LinkedList<Bool>()
        for node in nodes {
            list.append(node)
        }
        return (nodes, list)
    }
    static func buildNotes(_ data: [String]) -> BinaryTree<Bool> { // 1, 2, 4, 8, 16, 32
        let root = BinaryTree(true)
        let tree2 = buildTrees(root)
        let tree4 = tree2.flatMap { buildTrees($0) }
        let tree8 = tree4.flatMap { buildTrees($0) }
        let tree16 = tree8.flatMap { buildTrees($0) }
        _ = tree16.flatMap { buildTrees($0) }

        for note in data.compactMap(PlantNote.init) {
            var query = [true]
            query.append(contentsOf: note.pattern)
            root.add(note.result, to: query)
        }
        return root
    }
    private static func buildTrees(_ tree: BinaryTree<Bool>) -> [BinaryTree<Bool>] {
        tree.left = BinaryTree(true)
        tree.right = BinaryTree(false)
        return [tree.left!, tree.right!]
    }
    static func printPots(_ pots: [Bool]) {
        print(pots.map { $0 ? "#" : "." }.reduce("", +))
    }
}
private struct PlantNote {
    let pattern: [Bool]
    let result: Bool
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^([#\\.]{5}) => ([#\\.]{1})$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        pattern = data.match(match, at: 1).map { $0 == "#" ? true : false }
        result = data.match(match, at: 2) == "#" ? true : false
    }
}
private extension BinaryTree {
    func add(_ result: T, to query: [T]) {
        add(result, to: query, index: 0)
    }
    private func add(_ result: T, to query: [T], index: Int) {
        guard query[index] == value else {
            return
        }
        if index == query.count - 1 {
            left = BinaryTree(result)
            right = nil
            return
        }
        left?.add(result, to: query, index: index + 1)
        right?.add(result, to: query, index: index + 1)
    }
}

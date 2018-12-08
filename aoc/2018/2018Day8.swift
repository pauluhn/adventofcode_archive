//
//  2018Day8.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day8 {
    static func Part1(_ data: String) -> Int {
        let entries = data.components(separatedBy: .whitespaces)
        return readNode1(entries).sum
    }
    static func Part2(_ data: String) -> Int {
        let entries = data.components(separatedBy: .whitespaces)
        return readNode2(entries).sum
    }
}
private extension Y2018Day8 {
    static func readNode1(_ entries: [String]) -> (entries: [String], sum: Int) {
        var entries = entries
        let childCount = entries.removeFirst().int
        let metadata = entries.removeFirst().int
        
        var sum = 0
        for _ in 0..<childCount {
            let (e, s) = readNode1(entries)
            entries = e
            sum += s
        }
        for _ in 0..<metadata {
            sum += entries.removeFirst().int
        }
        return (entries, sum)
    }
    static func readNode2(_ entries: [String]) -> (entries: [String], sum: Int) {
        var entries = entries
        let childCount = entries.removeFirst().int
        let metadata = entries.removeFirst().int
        
        var children = [Int]()
        for _ in 0..<childCount {
            let (e, s) = readNode2(entries)
            entries = e
            children.append(s)
        }
        var sum = 0
        for _ in 0..<metadata {
            let entry = entries.removeFirst().int
            if childCount == 0 {
                sum += entry
            } else if entry - 1 < childCount {
                sum += children[entry - 1]
            }
        }
        return (entries, sum)
    }
}

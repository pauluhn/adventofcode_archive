//
//  2018Day2.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day2 {
    static func Part1(_ data: [String]) -> Int {
        assert("abcdef".twoThreeCount() == (0, 0))
        assert("bababc".twoThreeCount() == (1, 1))
        assert("abbcde".twoThreeCount() == (1, 0))
        assert("abcccd".twoThreeCount() == (0, 1))
        assert("aabcdd".twoThreeCount() == (1, 0))
        assert("abcdee".twoThreeCount() == (1, 0))
        assert("ababab".twoThreeCount() == (0, 1))
        
        let initial = String.TwoThreeCount(two: 0, three: 0)
        let twoThree = data.map { $0.twoThreeCount() }.reduce(initial) { ($0.two + $1.two, $0.three + $1.three) }
        return twoThree.two * twoThree.three
    }
    static func Part2(_ data: [String]) -> String {
        var best: [Character] = []
        for (offset, lhs) in data.enumerated() {
            for rhs in data.dropFirst(offset + 1) {
                var current: [Character] = []
                for (l, r) in zip(lhs, rhs) where l == r {
                    current.append(l)
                }
                best = best.longer(than: current) ? best : current
            }
        }
        return String(best)
    }
}

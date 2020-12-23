//
//  2020Day23.swift
//  aoc
//
//  Created by Paul U on 12/23/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day23 {

    private static func compute(_ data: String, _ moves: Int, _ total: Int = 9) -> [Int: Int] {
        var cups = Dictionary<Int, Int>(minimumCapacity: total)
        var current = 0
        var previous = 0
        for d in data {
            if previous > 0 {
                cups[previous] = d.int
                previous = d.int
            } else {
                current = d.int
                previous = d.int
            }
        }
        cups[previous] = current
        // add cups
        if cups.count < total {
            for i in 10 ... total {
                cups[previous] = i
                previous = i
            }
        }
        cups[previous] = current
        let max = cups.keys.max()!

        for _ in 0 ..< moves {
            // pick up
            let r = cups[current]!
            let (rn, rr) = { r -> (Int, [Int]) in
                var rn = r
                var rr = [r]
                for _ in 0 ..< 3 {
                    rn = cups[rn]!
                    rr += [rn]
                }
                return (rn, rr.dropLast())
            }(r)
            let rl = rr.last!
            cups[current] = rn

            // select destination
            var destination = current
            var found = false
            if current > 1 {
                for i in (1 ... current - 1).reversed() where !rr.contains(i) {
                    destination = i
                    found = true
                    break
                }
            }
            if !found {
                for i in (current + 1 ... max).reversed() where !rr.contains(i) {
                    destination = i
                    break
                }
            }

            // places
            let dn = cups[destination]
            cups[destination] = r
            cups[rl] = dn

            // select current
            current = cups[current]!
        }
        return cups
    }
    
    static func Part1(_ data: String, _ moves: Int) -> String {
        let cups = compute(data, moves)
        let a = { c -> ([Int]) in
            var a = [c]
            var r = c
            for _ in 0 ..< 8 {
                r = cups[r]!
                a += [r]
            }
            return a.prefix(8).map({$0})
        }(cups[1]!)
        return a.map { $0.str }.joined()
    }
    
    static func Part2(_ data: String) -> Int {
        let cups = compute(data, 10_000_000, 1_000_000)
        let a = cups[1]!
        let b = cups[a]!
        return a * b
    }
}

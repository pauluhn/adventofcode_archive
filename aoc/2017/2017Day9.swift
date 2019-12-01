//
//  2017Day9.swift
//  aoc
//
//  Created by Paul Uhn on 11/8/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day9 {
    
    static func Part1(_ data: String) -> Int {
        assert(garbage("<>").0) // empty garbage.
        assert(garbage("<random characters>").0) // garbage containing random characters.
        assert(garbage("<<<<>").0) // because the extra < are ignored.
        assert(garbage("<{!>}>").0) // because the first > is canceled.
        assert(garbage("<!!>").0) // because the second ! is canceled, allowing the > to terminate the garbage.
        assert(garbage("<!!!>>").0) // because the second ! and the first > are canceled.
        assert(garbage("<{o\"i!a,<{i<a>").0) // which ends at the first >.
        
        assert(garbage("<>a").1 == "a") // remove garbage and return remaining
        
        assert(groups("{}").0 == 1) // 1 group.
        assert(groups("{{{}}}").0 == 3) // 3 groups.
        assert(groups("{{},{}}").0 == 3) // also 3 groups.
        assert(groups("{{{},{},{{}}}}").0 == 6) // 6 groups.
        assert(groups("{<{},{},{{}}>}").0 == 1) // 1 group (which itself contains garbage).
        assert(groups("{<a>,<a>,<a>,<a>}").0 == 1) // 1 group.
        assert(groups("{{<a>},{<a>},{<a>},{<a>}}").0 == 5) // 5 groups.
        assert(groups("{{<!>},{<!>},{<!>},{<a>}}").0 == 2) // 2 groups (since all but the last > are canceled).

        return groups(data).1
    }
    
    static func Part2(_ data: String) -> Int {
        assert(garbage("<>").2 == 0) // 0 characters.
        assert(garbage("<random characters>").2 == 17) // 17 characters.
        assert(garbage("<<<<>").2 == 3) // 3 characters.
        assert(garbage("<{!>}>").2 == 2) // 2 characters.
        assert(garbage("<!!>").2 == 0) // 0 characters.
        assert(garbage("<!!!>>").2 == 0) // 0 characters.
        assert(garbage("<{o\"i!a,<{i<a>").2 == 10) // 10 characters.
        
        return groups(data).2
    }
    
    private static func groups(_ data: String, _ base: Int = 0) -> (Int, Int, Int) {
        var base = base
        var count = 0
        var score = 0
        for (i, c) in data.enumerated() {
            switch c {
            case "{": count += 1; base += 1; score += base
            case "}": base -= 1
            case "<":
                let results = garbage(String(data.dropFirst(i)))
                let tuple = groups(results.1, base)
                return (tuple.0 + count, tuple.1 + score, tuple.2 + results.2)
            default: break
            }
        }
        return (count, score, 0)
    }
    
    private static func garbage(_ data: String) -> (Bool, String, Int) {
        guard let first = data.first, first == "<" else { return (false, "", 0) }
        let remaining = data.dropFirst()
        
        var ignore = false
        var count = 0
        for (i, c) in remaining.enumerated() {
            if ignore { ignore = false; continue }
            
            switch c {
            case ">":
                let returnString = String(remaining.dropFirst(i + 1))
                return (true, returnString, count)
            case "!": ignore = true
            default: count += 1
            }
        }
        
        
        return (false, "", 0)
    }
}

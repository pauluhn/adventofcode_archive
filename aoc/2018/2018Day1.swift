//
//  2018Day1.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day1 {
    static func Part1(_ data: [String]) -> Int {
        return data.compactMap(Int.init).reduce(0, +)
    }
    static func Part2(_ data: [String]) -> Int {
        let frequencies = data.compactMap(Int.init)
        var duplicate = false
        var runningFrequency = 0
        let countedSet = NSCountedSet(array: [0])
        while !duplicate {
            for frequency in frequencies {
                runningFrequency += frequency
                countedSet.add(runningFrequency)
                if countedSet.count(for: runningFrequency) == 2 {
                    duplicate = true
                    break
                }
            }
        }
        return runningFrequency
    }
}

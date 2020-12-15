//
//  2020Day15.swift
//  aoc
//
//  Created by Paul U on 12/15/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day15 {
    
    static func compute(_ data: [Int], _ max: Int) -> Int {
        var store = [Int: Int]()
        for (n, i) in data.enumerated() {
            store[i] = n + 1
        }
        var number = 0

        for round in data.count + 1 ..< max {
            if let r = store[number] {
                store[number] = round
                number = round - r
                
            } else {
                store[number] = round
                number = 0
            }
        }
        return number
    }
    
    static func Part1(_ data: [Int]) -> Int {
        return compute(data, 2020)
    }
    
    static func Part2(_ data: [Int]) -> Int {
        return compute(data, 30000000)
    }
}

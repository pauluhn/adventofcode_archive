//
//  2020Day15.swift
//  aoc
//
//  Created by Paul U on 12/15/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day15 {
    
    static func Part1(_ data: [Int]) -> Int {
        var store = [Int: [Int]]()
        var number = 0
        
        for (n, i) in data.enumerated() {
            store[i] = [n + 1]
            number = i
        }
        var isNew = true
        
        for round in data.count + 1 ... 2020 {
            if isNew {
                number = 0
                if store[number] == nil {
                    store[number] = []
                } else {
                    isNew = false
                }
                store[number]?.append(round)

            } else {
                let rounds = store[number]!
                let count = rounds.count
                number = rounds[count - 1] - rounds[count - 2]
                if store[number] == nil {
                    store[number] = []
                    isNew = true
                }
                store[number]?.append(round)
            }
        }
        return number
    }
}

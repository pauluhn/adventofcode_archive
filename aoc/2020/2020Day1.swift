//
//  2020Day1.swift
//  aoc
//
//  Created by Paul U on 12/1/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day1 {
    
    static func Part1(_ data: [String]) -> Int {
        let expenses = data.compactMap(Int.init)
        let sums = expenses.flatMap { expense in
            expenses.map { (expense, $0) }
        }
        let answer = sums
            .first { $0.0 + $0.1 == 2020 }
            .map { $0.0 * $0.1 }
        return answer!
    }

    static func Part2(_ data: [String]) -> Int {
        let expenses = data.compactMap(Int.init)
        
        for i in 0 ..< expenses.count - 2 {
            for j in i + 1 ..< expenses.count - 1 {
                for k in i + 2 ..< expenses.count {
                    if expenses[i] + expenses[j] + expenses[k] == 2020 {
                        return expenses[i] * expenses[j] * expenses[k]
                    }
                }
            }
        }
        return 0
    }
}

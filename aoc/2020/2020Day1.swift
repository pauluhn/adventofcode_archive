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
}

//
//  2020Day10.swift
//  aoc
//
//  Created by Paul U on 12/10/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day10 {

    static func Part1(_ data: [String]) -> Int {
        let jolts = data
            .compactMap(Int.init)
            .sorted()
        let count = jolts
            .reduce(into: [(jolt: Int, diff: Int)]()) {
                let prev = $0.isEmpty ? 0 : $0.last!.jolt
                $0.append(($1, $1 - prev))
            }
            .map { $0.diff }
            .filter { $0 == 1 }
            .count
        return count * (jolts.count - count + 1)
    }
}

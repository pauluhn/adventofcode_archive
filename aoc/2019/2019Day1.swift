//
//  2019Day1.swift
//  aoc
//
//  Created by Paul Uhn on 12/1/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day1 {

    static func Part1(_ data: [String]) -> Int {
        return data.compactMap(Int.init)
            .reduce(0) {
                $0 + ($1 / 3) - 2
            }
    }
}

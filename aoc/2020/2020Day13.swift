//
//  2020Day13.swift
//  aoc
//
//  Created by Paul U on 12/13/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day13 {

    static func Part1(_ data: [String]) -> Int {
        guard data.count >= 2 else { fatalError() }
        let timestamp = data[0].int
        let bus = data[1]
            .split(separator: ",")
            .map { $0.str.int }
            .filter { $0 > 0 }
            .map { ($0, $0 - (timestamp % $0)) }
            .min { $0.1 < $1.1 }!
        return bus.0 * bus.1
    }
}

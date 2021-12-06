//
//  2021Day6.swift
//  aoc
//
//  Created by Paul U on 12/5/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day6 {

    static func Part1(_ data: [String], days: Int = 80) -> Int {
        count(data, days)
    }

    static func Part2(_ data: [String]) -> Int {
        count(data, 256)
    }

    private static func count(_ data: [String], _ days: Int) -> Int {
        var fish = Array(repeating: 0, count: 9)
        data.forEach { fish[$0.int] += 1 }

        for _ in 0..<days {
            let spawn = fish[0]

            for i in 0..<8 {
                fish[i] = fish[i + 1]
            }
            fish[6] += spawn
            fish[8] = spawn
        }
        return fish.reduce(0, +)
    }
}

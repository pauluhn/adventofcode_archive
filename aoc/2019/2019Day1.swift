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
    
    static func Part2(_ data: [String]) -> Int {
        return data.compactMap(Int.init)
            .reduce(0) {
                var total = 0
                var fuel = 0
                var mass = $1
                repeat {
                    total += fuel
                    fuel = (mass / 3) - 2
                    mass = fuel
                } while fuel >= 0
                
                return $0 + total
        }
    }
}

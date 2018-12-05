//
//  2018Day5.swift
//  aoc
//
//  Created by Paul Uhn on 12/5/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day5 {
    static func Part1(_ data: String) -> Int {
        var units = data.map(PolymerUnit.init)
        
        var reactions: Int
        repeat {
            reactions = 0
            for (index, unit) in units.enumerated() {
                guard index < units.count - 1 else { continue }
                guard !units[index].isDead else { continue }
                
                if unit.reacts(to: units[index + 1]) {
                    reactions += 1
                    units[index].isDead = true
                    units[index + 1].isDead = true
                }
            }
            units = units.filter { !$0.isDead }
        } while reactions > 0
        return units.count
    }
    static func Part2(_ data: String) -> Int {
        let units = data.map(PolymerUnit.init)
        
        // how many unit types
        let keys = Set(units.map { $0.type } )

        // remove
        var shortestPolymer = Int.max
        for key in keys {
            let filteredData = units.filter { $0.type != key }.reduce("", { $0 + $1.description })
            shortestPolymer = min(shortestPolymer, Part1(filteredData))
        }
        return shortestPolymer
    }
}

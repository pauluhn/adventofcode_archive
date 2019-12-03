//
//  2019Day2.swift
//  aoc
//
//  Created by Paul Uhn on 12/2/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day2 {
    static func Part1(_ data: String, _ enable1202: Bool = false) -> [Int] {
        var intcode = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        var pointer = 0
        
        if enable1202 {
            intcode[1] = 12
            intcode[2] = 2
        }
        
        while true {
            switch intcode[pointer] {
            case 1:
                let first = intcode[intcode[pointer + 1]]
                let second = intcode[intcode[pointer + 2]]
                intcode[intcode[pointer + 3]] = first + second
                pointer += 4
            case 2:
                let first = intcode[intcode[pointer + 1]]
                let second = intcode[intcode[pointer + 2]]
                intcode[intcode[pointer + 3]] = first * second
                pointer += 4
            case 99:
                return intcode
            default:
                fatalError()
            }
        }
    }
}

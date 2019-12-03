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
        
        if enable1202 {
            intcode[1] = 12
            intcode[2] = 2
        }
        return program(intcode)
    }
    
    static func Part2(_ data: String) -> Int {
        var intcode = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        let answer = 19690720
        
        for i in 0..<100 { // 89
            for j in 0..<100 { // 76
                intcode[1] = i
                intcode[2] = j
                if let first = program(intcode).first, first == answer {
                    return 100 * i + j
                }
            }
        }
        
        return 0
    }
    
    private static func program(_ intcode: [Int]) -> [Int] {
        var intcode = intcode
        var pointer = 0
        var success = true
    
        while true {
            switch intcode[pointer] {
            case 1:
                add(&intcode, &pointer, &success)
            case 2:
                multiply(&intcode, &pointer, &success)
            case 99:
                return intcode
            default:
                fatalError()
            }
            if !success {
                return []
            }
        }
    }
    
    private static func add(_ intcode: inout [Int], _ pointer: inout Int, _ success: inout Bool) {
        guard check(intcode, pointer) else { success = false; return }
        let first = intcode[intcode[pointer + 1]]
        let second = intcode[intcode[pointer + 2]]
        intcode[intcode[pointer + 3]] = first + second
        pointer += 4
    }

    private static func multiply(_ intcode: inout [Int], _ pointer: inout Int, _ success: inout Bool) {
        guard check(intcode, pointer) else { success = false; return }
        let first = intcode[intcode[pointer + 1]]
        let second = intcode[intcode[pointer + 2]]
        intcode[intcode[pointer + 3]] = first * second
        pointer += 4
    }
    
    private static func check(_ intcode: [Int], _ pointer: Int) -> Bool {
        let first = intcode[pointer + 1]
        let second = intcode[pointer + 2]
        let third = intcode[pointer + 3]
        return first < intcode.count && second < intcode.count && third < intcode.count
    }
}

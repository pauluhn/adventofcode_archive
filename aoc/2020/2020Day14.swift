//
//  2020Day14.swift
//  aoc
//
//  Created by Paul U on 12/14/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day14 {
    
    struct Mask {
        enum Delta: Character {
            case zero = "0"
            case one = "1"
            case none = "X"
        }
        let bitmask: [Delta] // 36
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^mask = ([01X]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            bitmask = data
                .match(match, at: 1)
                .compactMap(Delta.init)
            guard bitmask.count == 36 else { fatalError() }
        }
        func write(_ value: Int) -> Int {
            let value = value.binaryString(length: bitmask.count)
            return zip(value, bitmask)
                .map { (c, delta) -> Character in
                    if delta == .none {
                        return c
                    } else {
                        return delta.rawValue
                    }
                }
                .string
                .binaryInt
        }
    }
    
    struct Memory {
        let address: Int
        let value: Int
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^mem\\[([0-9]+)\\] = ([0-9]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            address = data.match(match, at: 1).int
            value = data.match(match, at: 2).int
        }
    }

    static func Part1(_ data: [String]) -> Int {
        var cache: Mask?
        var store = [Int: Int]()
        
        for line in data {
            if let mask = Mask(line) {
                cache = mask
                
            } else if let memory = Memory(line) {
                store[memory.address] = cache?.write(memory.value)
            }
        }
        return store.values.reduce(0, +)
    }
}

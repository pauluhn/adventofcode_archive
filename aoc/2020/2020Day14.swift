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
            case cross = "X"
        }
        let orMask: Int // for 1
        let andMask: Int // for 0
        let xorMasks: [Int] // for floating
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^mask = ([01X]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            let bitmask = data
                .match(match, at: 1)
                .compactMap(Delta.init)
            guard bitmask.count == 36 else { fatalError() }

            orMask = bitmask
                .map { $0 == .one ? "1" : "0" }
                .string
                .binaryInt
            andMask = bitmask
                .map { $0 == .zero ? "0" : "1" }
                .string
                .binaryInt
            
            var xorMasks = [Int]()
            for (n, b) in bitmask.reversed().enumerated() where b == .cross {
                xorMasks += [Int(pow(2, Double(n)))]
            }
            self.xorMasks = xorMasks
        }
        func write(_ value: Int) -> Int {
            return (value | orMask) & andMask
        }
        func write(_ address: Int) -> [Int] {
            var addresses = [(address | orMask)]
            for xorMask in xorMasks {
                addresses += addresses.map { ($0 ^ xorMask) }
            }
            return addresses
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

    static func Part2(_ data: [String]) -> Int {
        var cache: Mask?
        var store = [Int: Int]()
        
        for line in data {
            if let mask = Mask(line) {
                cache = mask
                
            } else if let memory = Memory(line) {
                for address in cache!.write(memory.address) {
                    store[address] = memory.value
                }
            }
        }
        return store.values.reduce(0, +)
    }
}

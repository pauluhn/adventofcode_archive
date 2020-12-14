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
                    if delta == .cross {
                        return c
                    } else {
                        return delta.rawValue
                    }
                }
                .string
                .binaryInt
        }
        func addresses(_ address: Int) -> [Int] {
            let address = address.binaryString(length: bitmask.count)
            let tuples = zip(address, bitmask)
                .map { (c, delta) -> (Character, Bool) in
                    switch delta {
                    case .zero: return (c, false)
                    case .one: return ("1", false)
                    case .cross: return ("0", true)
                    }
                }
            
            let base = tuples
                .map { $0.0 }
                .string
            
            var addresses = [String]()
            for (n, float) in tuples.enumerated() where float.1 {
                if addresses.isEmpty {
                    addresses += [base]
                }
                let updated = addresses.map { address -> String in
                    var updated = address.map { $0 }
                    updated[n] = "1"
                    return updated.string
                }
                addresses += updated
            }
            return addresses.map { $0.binaryInt }
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
                for address in cache!.addresses(memory.address) {
                    store[address] = memory.value
                }
            }
        }
        return store.values.reduce(0, +)
    }
}

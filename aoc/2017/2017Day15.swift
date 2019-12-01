//
//  2017Day15.swift
//  aoc
//
//  Created by Paul Uhn on 11/25/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day15 {
    
    private struct Generator {
        enum Name { case A, B }
        let factor: Int
        let mod: Int
        let multipleOf: Int
        private var value: Int
        
        init(name: Name, seed: Int, isPart2: Bool = false) {
            switch name {
            case .A:
                factor = 16807
                multipleOf = isPart2 ? 4 : 1
            case .B:
                factor = 48271
                multipleOf = isPart2 ? 8 : 1
            }
            mod = 2147483647
            value = seed
        }
        
        mutating func compute() -> Int {
            value = (value * factor) % mod
            guard value % multipleOf == 0 else {
                return compute()
            }
            return value
        }
    }

    static func Part1(_ a: Int, _ b: Int) -> Int {
        var genA = Generator(name: .A, seed: a)
        var genB = Generator(name: .B, seed: b)
        var pairs = 0
        
        for i in 0 ..< 40_000_000 {
            let a = genA.compute()
            let b = genB.compute()
            
            if judge(i, a, b) {
                pairs += 1
            }
        }
        return pairs
    }
    
    static func Part2(_ a: Int, _ b: Int) -> Int {
        var genA = Generator(name: .A, seed: a, isPart2: true)
        var genB = Generator(name: .B, seed: b, isPart2: true)
        var pairs = 0
        
        for i in 0 ..< 5_000_000 {
            let a = genA.compute()
            let b = genB.compute()
            
            if judge(i, a, b) {
                pairs += 1
            }
        }
        return pairs
    }
    
    private static func judge(_ i: Int, _ a: Int, _ b: Int) -> Bool {
        if i < 5 {
            print("\(a),\(b)")
        }
        
        let binaryA = a.binaryString(length: 16).suffix(16)
        let binaryB = b.binaryString(length: 16).suffix(16)
        
        if i < 5 {
            print("\(binaryA)\n\(binaryB)\n")
        }
        
        return binaryA == binaryB
    }
}

//
//  2017Day15.swift
//  aoc
//
//  Created by Paul Uhn on 11/25/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day15 {

    static func Part1(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        let factorA = 16807
        let factorB = 48271
        let mod = 2147483647
        
        var pairs = 0
        
        for i in 0 ..< 40_000_000 {
            a = (a * factorA) % mod
            b = (b * factorB) % mod
            
            if i < 5 {
                print("\(a),\(b)")
            }
            
            let binaryA = a.binaryString(length: 16).suffix(16)
            let binaryB = b.binaryString(length: 16).suffix(16)
            
            if i < 5 {
                print("\(binaryA)\n\(binaryB)\n")
            }
            
            if binaryA == binaryB {
                pairs += 1
            }
        }
        return pairs
    }
}

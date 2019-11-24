//
//  2017Day14.swift
//  aoc
//
//  Created by Paul Uhn on 11/24/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day14 {

    static func Part1(_ data: String) -> Int {
        var total = 0
        for i in 0..<128 {
            let input = "\(data)-\(i)"
            let output = Y2017Day10.Part2(256, input)
            let row = output
                .compactMap { $0.hexDigitValue }
                .map { $0.binaryString(length: 4) }
                .joined()
            if i < 8 {
                print(row.prefix(8))
            }
            let count = row.reduce(0) { $0 + $1.int }
            total += count
        }
        return total
    }
}

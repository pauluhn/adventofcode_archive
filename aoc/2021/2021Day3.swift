//
//  2021Day3.swift
//  aoc
//
//  Created by Paul U on 12/3/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day3 {

    static func Part1(_ data: [String]) -> Int {
        let (gamma, epsilon) = commonTupleString(data)
        return gamma.binaryInt * epsilon.binaryInt
    }

    static func Part2(_ data: [String]) -> Int {
        let o2 = rating(data)
        let co2 = rating(data, isFirst: false)
        return o2.binaryInt * co2.binaryInt
    }

    fileprivate struct BitCounter {
        private(set) var common = 0
        private(set) var meter = 0
        private(set) var store = [Int]()
    }

    private static func commonTupleString(_ data: [String]) -> (String, String) {
        let (common, uncommon) = commonTupleInts(data)
        return (
            common.map { $0.str }.joined(),
            uncommon.map { $0.str }.joined()
        )
    }

    private static func commonTupleInts(_ data: [String]) -> ([Int], [Int]) {
        assert(!data.isEmpty)
        var counters = Array(repeating: BitCounter(), count: data[0].count)

        for line in data {
            for (i, bit) in line.enumerated() {
                counters[i].append(bit.int)
            }
        }
        let common = counters.map { $0.common }
        let uncommon = counters.map { $0.uncommon }

        return (common, uncommon)
    }

    private static func rating(_ data: [String], isFirst: Bool = true) -> String {
        assert(!data.isEmpty)
        var lines = data
        for i in 0..<data[0].count {
            assert(!lines.isEmpty)
            if lines.count == 1 { break }

            let (first, second) = commonTupleInts(lines)
            let (bit, value) = isFirst ? (first[i], 1) : (second[i], 0)

            if bit == -1 {
                lines = lines.filter { $0[i].int == value }
            } else {
                lines = lines.filter { $0[i].int == bit }
            }
        }
        return lines[0]
    }
}

private extension Y2021Day3.BitCounter {
    var uncommon: Int {
        if common == -1 { return -1 }
        return common == 0 ? 1 : 0
    }
    mutating func append(_ bit: Int) {
        assert(bit == 0 || bit == 1)
        store.append(bit)
        meter += bit == 0 ? -1 : 1

        if meter == 0 {
            common = -1
        } else {
            common = meter > 0 ? 1 : 0
        }
    }
}

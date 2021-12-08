//
//  2021Day8.swift
//  aoc
//
//  Created by Paul U on 12/7/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day8 {

    struct Entry {
        let signals: [String]
        let outputs: [String]
    }

    static func Part1(_ data: [String]) -> Int {
        let entries = data.map(Entry.init)
        let outputs = entries.flatMap { $0.outputs }
        let easy = outputs.filter {
            $0.count == 2 || $0.count == 3 || $0.count == 4 || $0.count == 7
        }
        return easy.count
    }

    static func Part2(_ data: [String]) -> Int {
        let entries = data.map(Entry.init)

        return entries.map { entry -> Int in
            let signals = entry.signals
            let one = signals.first { $0.count == 2 }!
            let four = signals.first { $0.count == 4 }!
            let seven = signals.first { $0.count == 3 }!
            let eight = signals.first { $0.count == 7 }!

            // remaining = 0, 2, 3, 5, 6, 9
            var remaining = signals.filter {
                $0.count != 2 && $0.count != 3 && $0.count != 4 && $0.count != 7
            }

            // ztn = 0, 3, 9 - include 1's segments
            let ztn = remaining.filter {
                Set($0).subtracting(one).count == $0.count - 2
            }
            let three = ztn.first { $0.count == 5 }!
            let nine = ztn.first {
                Set($0).subtracting(three).count == 1
            }!
            let zero = ztn.first { $0 != three && $0 != nine }!

            // remaining = 2, 5, 6
            remaining = remaining.filter { $0 != zero && $0 != three && $0 != nine }
            let six = remaining.first { $0.count == 6 }!

            // remaining = 2, 5
            remaining = remaining.filter { $0 != six }
            let five = remaining.first {
                Set(six).subtracting($0).count == 1
            }!
            let two = remaining.first { $0 != five }!

            let outputs = entry.outputs.map { Set($0) }
            let numbers = [zero, one, two, three, four, five, six, seven, eight, nine].map { Set($0) }

            let display = outputs.map { output -> Int in
                let (i, _) = numbers
                    .enumerated()
                    .first { i, number in
                        output == number
                    }!
                return i
            }

           return display
                .reversed()
                .enumerated()
                .map { i, n -> Int in
                    let exponent = Double(i)
                    let power = pow(10.0, exponent)
                    return n * Int(power)
                }
                .reduce(0, +)
        }
        .reduce(0, +)
    }
}

private extension Y2021Day8.Entry {
    init(_ data: String) {
        let data = data.split(separator: " ")
        assert(data.count == 10 + 1 + 4)

        signals = data.prefix(10).map { String($0) }
        outputs = data.suffix(4).map { String($0) }
    }
}

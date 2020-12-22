//
//  2020Day22.swift
//  aoc
//
//  Created by Paul U on 12/22/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day22 {
    
    struct Deck {
        let id: Int
        var cards: [Int]
        
        init?(_ data: String) {
            let data = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
            guard !data.isEmpty else { return nil }
            let regex = try! NSRegularExpression(pattern: "^Player ([0-9]):$")
            guard let match = regex.firstMatch(in: data[0], options: [], range: NSRange(location: 0, length: data[0].count)) else { return nil }
            id = data[0].match(match, at: 1).int
            cards = data[1...].map { $0.int }
        }
    }

    static func Part1(_ data: String) -> Int {
        var data = data
            .components(separatedBy: "\n\n")
            .compactMap(Deck.init)
        guard data.count == 2 else { fatalError() }

        while true {
            // top cards
            let a = data[0].cards.removeFirst()
            let b = data[1].cards.removeFirst()
            // winner
            if a > b {
                data[0].cards += [a, b]
            } else {
                data[1].cards += [b, a]
            }
            if data[0].cards.isEmpty || data[1].cards.isEmpty {
                break
            }
        }
        // score
        let cards = !data[0].cards.isEmpty ? data[0].cards : data[1].cards
        return zip(cards.reversed(), 1...)
            .map { $0 * $1 }
            .reduce(0, +)
    }
}

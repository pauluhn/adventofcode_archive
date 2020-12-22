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
        
        var hash: String { ([id] + cards).map { $0.str }.joined(separator: ".") }
        
        init?(_ data: String) {
            let data = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
            guard !data.isEmpty else { return nil }
            let regex = try! NSRegularExpression(pattern: "^Player ([0-9]):$")
            guard let match = regex.firstMatch(in: data[0], options: [], range: NSRange(location: 0, length: data[0].count)) else { return nil }
            id = data[0].match(match, at: 1).int
            cards = data[1...].map { $0.int }
        }
        private init(id: Int, cards: [Int]) {
            self.id = id
            self.cards = cards
        }
        func top(_ n: Int) -> Deck {
            Deck(id: id, cards: cards[0 ..< n].map { $0 })
        }
    }

    private static func parse(_ data: String) -> [Deck] {
        let data = data
            .components(separatedBy: "\n\n")
            .compactMap(Deck.init)
        guard data.count == 2 else { fatalError() }
        return data
    }
    
    static func Part1(_ data: String) -> Int {
        var data = parse(data)
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

    static func Part2(_ data: String) -> Int {
        var data = parse(data)
        var set = Set<String>()
        var winner = [Int]()
        while true {
            
            // check instant win
            let hash = data[0].hash + data[1].hash
            if set.contains(hash) {
                // player 1 wins
                winner = data[0].cards
                break
            } else {
                set.insert(hash)
                // top cards
                let a = data[0].cards.removeFirst()
                let b = data[1].cards.removeFirst()
                // check recursive
                if data[0].cards.count >= a && data[1].cards.count >= b {
                    let c = data[0].top(a)
                    let d = data[1].top(b)
                    if Subgame([c, d]) {
                        data[0].cards += [a, b]
                    } else {
                        data[1].cards += [b, a]
                    }
                } else {
                    // winner
                    if a > b {
                        data[0].cards += [a, b]
                    } else {
                        data[1].cards += [b, a]
                    }
                }
            }
            if data[0].cards.isEmpty {
                winner = data[1].cards
                break
            } else if data[1].cards.isEmpty {
                winner = data[0].cards
                break
            }
        }
        // score
        return zip(winner.reversed(), 1...)
            .map { $0 * $1 }
            .reduce(0, +)
    }
    
    private static func Subgame(_ data: [Deck]) -> Bool {
        guard data.count == 2 else { fatalError() }
        var data = data
        var set = Set<String>()
        while true {

            // check instant win
            let hash = data[0].hash + data[1].hash
            if set.contains(hash) {
                // player 1 wins
                return true
            }
            set.insert(hash)
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
        return !data[0].cards.isEmpty
    }
}

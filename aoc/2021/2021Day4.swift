//
//  2021Day4.swift
//  aoc
//
//  Created by Paul U on 12/4/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day4 {

    struct BingoGame {
        let inputs: [Int]
        var cards: [Card]

        struct Card {
            var grid: TwoDimensionalArray<Int>
            private(set) var mark: TwoDimensionalArray<Bool>
        }
    }

    static func Part1(_ data: [String]) -> Int {
        var game = parse(data)
        for input in game.inputs {
            for i in 0..<game.cards.count {
                game.cards[i].mark(input)
                if game.cards[i].check() {
                    let sum = game.cards[i].sum
                    return input * sum
                }
            }
        }
        return -1
    }

    static func Part2(_ data: [String]) -> Int {
        var game = parse(data)
        var cards = [Int]()

        for input in game.inputs {
            for i in 0..<game.cards.count {
                game.cards[i].mark(input)
                let open = cards.first { $0 == i } == nil
                if open, game.cards[i].check() {
                    cards.append(i)
                }
            }

            if cards.count == game.cards.count {
                let sum = game.cards[cards.last!].sum
                return input * sum
            }
        }
        return -1
    }
}

// MARK: - Parsing
private extension Y2021Day4 {
    static func parse(_ data: [String]) -> BingoGame {
        let inputs = parseInputs(data[0])
        assert(!inputs.isEmpty)
        let cards = parseCards(data.dropFirst())
        assert(!cards.isEmpty)
        return BingoGame(inputs: inputs, cards: cards)
    }
    static func parseInputs(_ data: String) -> [Int] {
        return data.commaSplit().map { $0.int }
    }
    static func parseCards(_ data: ArraySlice<String>) -> [BingoGame.Card] {
        var cards = [BingoGame.Card]()
        var card = BingoGame.Card.empty
        let rows = data.compactMap(parseCardRow)
        for (i, row) in rows.enumerated() {
            let y = i % 5
            for (x, value) in row.enumerated() {
                card.grid.set(x, y, to: value)
            }
            if y == 4 {
                cards.append(card)
                card = .empty
            }
        }
        return cards
    }
    static func parseCardRow(_ data: String) -> [Int]? {
        let regex = try! NSRegularExpression(pattern: "^\\s*([0-9]+)\\s*([0-9]+)\\s*([0-9]+)\\s*([0-9]+)\\s*([0-9]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        let first = data.match(match, at: 1).int
        let second = data.match(match, at: 2).int
        let third = data.match(match, at: 3).int
        let fourth = data.match(match, at: 4).int
        let fifth = data.match(match, at: 5).int
        return [first, second, third, fourth, fifth]
    }
}

// MARK: - Card
private extension Y2021Day4.BingoGame.Card {
    typealias Card = Y2021Day4.BingoGame.Card

    static var empty: Card {
        Card(
            grid: TwoDimensionalArray(repeating: 0, width: 5, height: 5),
            mark: TwoDimensionalArray(repeating: false, width: 5, height: 5)
        )
    }

    mutating func mark(_ value: Int) {
        if let (x, y) = grid.find(value) {
            mark.set(x, y, to: true)
        }
    }

    func check() -> Bool {
        var cols = Array(repeating: 0, count: 5)
        var rows = Array(repeating: 0, count: 5)
        for x in 0..<5 {
            for y in 0..<5 {
                if mark.get(x, y) {
                    cols[x] += 1
                    rows[y] += 1
                }
            }
        }
        return (cols + rows).first { $0 == 5 } != nil
    }

    var sum: Int {
        zip(grid.data, mark.data)
            .filter { $0.1 == false }
            .map { $0.0 }
            .reduce(0, +)
    }
}

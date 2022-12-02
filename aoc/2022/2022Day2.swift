//
//  2022Day2.swift
//  aoc
//
//  Created by Paul U on 11/30/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day2 {

    struct Round {
        enum Choice { case rock, paper, scissors }
        enum Result { case win, lose, draw }

        let opponent: Choice
        let mine: Choice
    }

    static func Part1(_ data: [String]) -> Int {
        let rounds = parse1(data)
        let shape = rounds.map { $0.mine.score }.reduce(0, +)
        let results = rounds.map { $0.result }
        let score = results.map { $0.score }.reduce(0, +)
        let final = shape + score
        return final
    }

    static func Part2(_ data: [String]) -> Int {
        let rounds = parse2(data)
        let shape = rounds.map { $0.mine.score }.reduce(0, +)
        let results = rounds.map { $0.result }
        let score = results.map { $0.score }.reduce(0, +)
        let final = shape + score
        return final
    }

    private static func parse1(_ data: [String]) -> [Round] {
        let rounds = data.map {
            let choices = $0.split(separator: " ")
            assert(choices.count == 2)
            let opponent = Round.Choice(opponent: choices.first!)
            let mine = Round.Choice(mine: choices.last!)
            let round = Round(opponent: opponent, mine: mine)
            return round
        }
        return rounds
    }

    private static func parse2(_ data: [String]) -> [Round] {
        let rounds = data.map {
            let choices = $0.split(separator: " ")
            assert(choices.count == 2)
            let opponent = Round.Choice(opponent: choices.first!)
            let result = Round.Result(mine: choices.last!)
            let mine = opponent.mine(result: result)
            let round = Round(opponent: opponent, mine: mine)
            return round
        }
        return rounds
    }
}

private extension Y2022Day2.Round.Choice {
    init(opponent: Substring) {
        switch opponent {
        case "A": self = .rock
        case "B": self = .paper
        case "C": self = .scissors
        default: fatalError()
        }
    }
    init(mine: Substring) {
        switch mine {
        case "X": self = .rock
        case "Y": self = .paper
        case "Z": self = .scissors
        default: fatalError()
        }
    }
    var score: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }
    // What is my choice given opponent and desired result?
    func mine(result: Y2022Day2.Round.Result) -> Y2022Day2.Round.Choice {
        switch result {
        case .win: return self.win
        case .lose: return self.lose
        case .draw: return self.draw
        }
    }
    var win: Self {
        switch self {
        case .rock: return .paper
        case .paper: return .scissors
        case .scissors: return .rock
        }
    }
    var lose: Self {
        switch self {
        case .rock: return .scissors
        case .scissors: return .paper
        case .paper: return .rock
        }
    }
    var draw: Self {
        switch self {
        case .rock: return .rock
        case .paper: return .paper
        case .scissors: return .scissors
        }
    }
}

private extension Y2022Day2.Round {
    var result: Result {
        switch (opponent, mine) {
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): return .draw
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock): return .lose
        default:
            return .win
        }
    }
}

private extension Y2022Day2.Round.Result {
    init(mine: Substring) {
        switch mine {
        case "X": self = .lose
        case "Y": self = .draw
        case "Z": self = .win
        default: fatalError()
        }
    }
    var score: Int {
        switch self {
        case .lose: return 0
        case .draw: return 3
        case .win: return 6
        }
    }
}

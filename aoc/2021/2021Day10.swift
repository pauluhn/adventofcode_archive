//
//  2021Day10.swift
//  aoc
//
//  Created by Paul U on 12/10/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day10 {

    enum Chunk: Character {
        case a_open = "("
        case a_close = ")"
        case b_open = "["
        case b_close = "]"
        case c_open = "{"
        case c_close = "}"
        case d_open = "<"
        case d_close = ">"

        var open: Bool {
            switch self {
            case .a_open, .b_open, .c_open, .d_open: return true
            default: return false
            }
        }
        func match(_ other: Chunk) -> Bool {
            switch (self, other) {
            case (.a_close, .a_open),
                (.b_close, .b_open),
                (.c_close, .c_open),
                (.d_close, .d_open): return true
            default: return false
            }
        }
    }

    static func Part1(_ data: [String]) -> Int {
        let data = data.map { $0.map { Chunk(rawValue: $0)! }}

        let scores = data.compactMap { chunks -> Int? in
            var stack = Stack<Chunk>()
            for chunk in chunks {
                if chunk.open {
                    stack.push(chunk)
                } else if let c = stack.peek(), chunk.match(c) {
                    stack.pop()
                } else {
                    switch chunk {
                    case .a_close: return 3
                    case .b_close: return 57
                    case .c_close: return 1197
                    case .d_close: return 25137
                    default: fatalError()
                    }
                }
            }
            return nil
        }
        return scores.reduce(0, +)
    }

    static func Part2(_ data: [String]) -> Int {
        let data = data.map { $0.map { Chunk(rawValue: $0)! }}

        let scores = data.compactMap { chunks -> Int? in
            var stack = Stack<Chunk>()
            for chunk in chunks {
                if chunk.open {
                    stack.push(chunk)
                } else if let c = stack.peek(), chunk.match(c) {
                    stack.pop()
                } else {
                    return nil
                }
            }
            let score = stack.stack.reversed().reduce(0) { partialResult, chunk in
                switch chunk {
                case .a_open: return partialResult * 5 + 1
                case .b_open: return partialResult * 5 + 2
                case .c_open: return partialResult * 5 + 3
                case .d_open: return partialResult * 5 + 4
                default: fatalError()
                }
            }
            return score
        }
        return scores.sorted()[scores.count / 2]
    }
}

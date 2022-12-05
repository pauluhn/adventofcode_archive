//
//  2022Day5.swift
//  aoc
//
//  Created by Paul U on 12/4/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day5 {

    typealias CrateStack = Stack<Character>

    struct Instruction {
        let move: Int
        let from: Int
        let to: Int
    }

    static func Part1(_ data: [String]) -> String {
        var (stacks, instructions) = parse(data)

        for instruction in instructions {
            for _ in 0..<instruction.move {
                let crate = stacks[instruction.from].pop()!
                stacks[instruction.to].push(crate)
            }
        }

        let tops = stacks.compactMap { $0.peek() }
        let answer = String(tops)

        return answer
    }

    static func Part2(_ data: [String]) -> String {
        var (stacks, instructions) = parse(data)

        for instruction in instructions {
            var crates = [Character]()
            for _ in 0..<instruction.move {
                let crate = stacks[instruction.from].pop()!
                crates.append(crate)
            }
            stacks[instruction.to].push(crates)
        }

        let tops = stacks.compactMap { $0.peek() }
        let answer = String(tops)

        return answer
    }

    private static func parse(_ data: [String]) -> ([CrateStack], [Instruction]) {

        enum State { case crateStack, instruction }
        var state = State.crateStack

        var stacks = [Int: [Character]]()
        var instructions = [Instruction]()

        for line in data {
            switch state {

            case .crateStack:
                guard line[1] != "1" else {
                    state = .instruction
                    continue
                }
                for index in stride(from: 1, to: line.count, by: 4) {
                    assert((index - 1) % 4 == 0)
                    let stack = (index - 1) / 4 + 1
                    let crates = stacks[stack, default: []]
                    let crate = line[index]
                    if crate != " " {
                        stacks[stack] = crates + [crate]
                    }
                }

            case .instruction:
                if let instruction = parse(line) {
                    instructions.append(instruction)
                }
            }
        }

        let crateStacks = stacks.sorted { $0.key < $1.key }
            .map { $0.value.reversed() }
            .map(Stack.init)

        return (crateStacks, instructions)
    }
    private static func parse(_ data: String) -> Instruction? {
        let regex = /^move ([0-9]+) from ([0-9]+) to ([0-9]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { return nil }

        let move = results.1.int
        let from = results.2.int - 1
        let to = results.3.int - 1

        return Instruction(move: move, from: from, to: to)
    }
}

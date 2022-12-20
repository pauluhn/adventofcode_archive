//
// Copyright © 2022 Paul Uhn. All rights reserved.
//

import Foundation

struct Y2022Day10 {

    enum Instruction {
        case noop
        case addx(Int)
    }

    static func Part0(_ data: [String]) -> Int {
        let instructions = parse(data)
        let inputs = compute(instructions)
        return inputs.last!
    }

    static func Part1(_ data: [String]) -> Int {
        let instructions = parse(data)
        let inputs = compute(instructions)

        var sum = 0
        for index in stride(from: 20, to: inputs.count, by: 40) {
            sum += index * inputs[index - 1]
        }
        return sum
    }

    static func Part2(_ data: [String]) {
        let instructions = parse(data)
        let inputs = compute(instructions)

        var crt = [[String]]()
        for index in 0..<inputs.count {
            let position = index % 40
            if position == 0 {
                crt.append([])
            }

            let middle = inputs[index]
            let sprite = [middle - 1, middle, middle + 1]
            let lit = sprite.contains(position)
            let pixel = lit ? "#" : "."
            crt[crt.count - 1].append(pixel)
        }
        printCRT(crt)
    }

    private static func compute(_ instructions: [Instruction]) -> [Int] {
        var register = 1
        var inputs = [Int]()

        for instruction in instructions {
            switch instruction {
            case .noop:
                inputs.append(register)

            case .addx(let value):
                inputs.append(register)
                inputs.append(register)
                register += value
            }
        }
        return inputs + [register]
    }

    private static func printCRT(_ crt: [[String]]) {
        let display = crt
            .map { $0.joined() }
            .joined(separator: "\n")
        print(display)
    }
}

private extension Y2022Day10 {

    static func parse(_ data: [String]) -> [Instruction] {
        var instructions = [Instruction]()
        for line in data {
            if let addx = parse(line) {
                instructions.append(.addx(addx))
            } else if line == "noop" {
                instructions.append(.noop)
            } else { fatalError() }
        }
        return instructions
    }

    private static func parse(_ data: String) -> Int? {
        let regex = /^addx (-?[0-9]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { return nil }

        let int = results.1.int
        return int
    }
}

//
// Copyright © 2022 Paul Uhn. All rights reserved.
//

import Foundation

struct Y2022Day9 {

    struct Rope {
        var head = Vector2.zero
        var tail = Vector2.zero
        var visited = Grid2(vectors: [Vector2.zero], value: true)
    }

    static func Part1(_ data: [String]) -> Int {
        let directions = parse(data)
        var rope = Rope()

        for (direction, count) in directions {
            for _ in 0..<count {
                rope.moveHead(to: rope.head + direction.vector)
            }
        }
        let count = rope.visited.values.count
        return count
    }

    static func Part2(_ data: [String]) -> Int {
        return 0
    }
}

private extension Y2022Day9.Rope {
    
    mutating func moveHead(to vector: Vector2) {
        guard head != vector else { return }
        let offset = vector - head
        if let direction = [Direction.up, .down, .left, .right]
            .first(where: { $0.vector == offset }) {

            head = vector
            moveTail(direction)
        }
        else {
            fatalError()
        }
    }

    private mutating func moveTail(_ direction: Direction) {
        let offset = head - tail
        guard abs(offset.x) > 1 || abs(offset.y) > 1 else { return }
        switch direction {
        case .up: tail = head + Vector2.down
        case .down: tail = head + Vector2.up
        case .left: tail = head + Vector2.right
        case .right: tail = head + Vector2.left
        default: fatalError()
        }
        visited.set(for: tail, value: true)
    }
}

private extension Y2022Day9 {

    static func parse(_ data: [String]) -> [(Direction, Int)] {
        return data.compactMap { parse($0) }
    }

    private static func parse(_ data: String) -> (Direction, Int)? {
        let regex = /^([UDLR]) ([0-9]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { return nil }

        let direction = parse(direction: results.1.str)
        let count = results.2.int
        return (direction, count)
    }

    private static func parse(direction: String) -> Direction {
        switch direction {
        case "U": return .up
        case "D": return .down
        case "L": return .left
        case "R": return .right
        default: fatalError()
        }
    }
}


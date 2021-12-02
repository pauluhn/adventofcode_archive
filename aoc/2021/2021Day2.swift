//
//  2021Day2.swift
//  aoc
//
//  Created by Paul U on 12/2/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day2 {

    typealias Position = Point
    typealias AimPosition = Point3D
    enum Command {
        case forward(Int)
        case down(Int)
        case up(Int)
    }

    static func Part1(_ data: [String]) -> Int {
        let commands = data.compactMap(Command.parse)

        let final = commands.reduce(Position.zero) { current, command in
            switch command {
            case .forward(let value): return current.offset(by: .init(horizontal: value))
            case .down(let value): return current.offset(by: .init(depth: value))
            case .up(let value): return current.offset(by: .init(depth: -value))
            }
        }
        let result = final.horizontal * final.depth
        return result
    }

    static func Part2(_ data: [String]) -> Int {
        let commands = data.compactMap(Command.parse)

        let final = commands.reduce(AimPosition.zero) { current, command in
            switch command {
            case .forward(let value): return current.offset(by: .init(horizontal: value, depth: value * current.aim))
            case .down(let value): return current.offset(by: .init(aim: value))
            case .up(let value): return current.offset(by: .init(aim: -value))
            }
        }
        let result = final.horizontal * final.depth
        return result
    }
}

private extension Y2021Day2.Command {
    typealias Command = Y2021Day2.Command
    static func parse(_ data: String) -> Command? {
        let regex = try! NSRegularExpression(pattern: "^([a-z]+) ([0-9]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        let command = data.match(match, at: 1)
        let value = data.match(match, at: 2).int

        switch command {
        case "forward": return .forward(value)
        case "down": return .down(value)
        case "up": return .up(value)
        default: return nil
        }
    }
}
private extension Y2021Day2.Position {
    var horizontal: Int { x }
    var depth: Int { y }
    init(horizontal: Int) { self.init(x: horizontal, y: 0) }
    init(depth: Int) { self.init(x: 0, y: depth) }
}
private extension Y2021Day2.AimPosition {
    var horizontal: Int { x }
    var depth: Int { y }
    var aim: Int { z }
    init(aim: Int) { self.init(x: 0, y: 0, z: aim) }
    init(horizontal: Int, depth: Int) { self.init(x: horizontal, y: depth, z: 0) }
}

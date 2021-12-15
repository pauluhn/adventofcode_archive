//
//  2021Day13.swift
//  aoc
//
//  Created by Paul U on 12/13/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day13 {

    enum Fold {
        case up(y: Int)
        case left(x: Int)
    }

    static func Part1(_ data: [String]) -> Int {
        var (grid, folds) = parse(data)

        switch folds.first! {
        case .up(let y):
            let dots = grid.keys.filter { $0.y > y }
            dots.forEach {
                grid.reset(key: $0)
                let diff = $0.y - y
                let new = Vector2(x: $0.x, y: y - diff)
                grid.set(for: new, value: "#")
            }

        case .left(let x):
            let dots = grid.keys.filter { $0.x > x }
            dots.forEach {
                grid.reset(key: $0)
                let diff = $0.x - x
                let new = Vector2(x: x - diff, y: $0.y)
                grid.set(for: new, value: "#")
            }
        }
        return grid.keys.count
    }

    static func Part2(_ data: [String]) -> String {
        var (grid, folds) = parse(data)

        folds.forEach { fold in
            switch fold {
            case .up(let y):
                let dots = grid.keys.filter { $0.y > y }
                dots.forEach {
                    grid.reset(key: $0)
                    let diff = $0.y - y
                    let new = Vector2(x: $0.x, y: y - diff)
                    grid.set(for: new, value: "#")
                }

            case .left(let x):
                let dots = grid.keys.filter { $0.x > x }
                dots.forEach {
                    grid.reset(key: $0)
                    let diff = $0.x - x
                    let new = Vector2(x: x - diff, y: $0.y)
                    grid.set(for: new, value: "#")
                }
            }
        }
        print(grid)
        return "LGHEGUEJ"
    }

    private static func parse(_ data: [String]) -> (Grid2<String>, [Fold]) {
        let vectors = data.compactMap { parseDots($0) }
        let grid = Grid2(vectors: vectors, value: "#")
        let folds = data.compactMap { parseFolds($0) }
        return (grid, folds)
    }

    private static func parseDots(_ data: String) -> Vector2? {
        let regex = try! NSRegularExpression(pattern: "^([0-9]+),([0-9]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        let x = data.match(match, at: 1).int
        let y = data.match(match, at: 2).int
        return Vector2(x: x, y: y)
    }

    private static func parseFolds(_ data: String) -> Y2021Day13.Fold? {
        let regex = try! NSRegularExpression(pattern: "^fold along ([xy])=([0-9]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        let xy = data.match(match, at: 1)
        let value = data.match(match, at: 2).int
        switch xy {
        case "x": return .left(x: value)
        case "y": return .up(y: value)
        default: fatalError()
        }
    }

}

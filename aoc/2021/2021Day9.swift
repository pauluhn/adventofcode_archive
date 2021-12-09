//
//  2021Day9.swift
//  aoc
//
//  Created by Paul U on 12/8/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day9 {

    static func Part1(_ data: [String]) -> Int {
        let (grid, lows) = parse(data)
        
        let risk = lows
            .compactMap { grid.get(for: $0) }
            .map { $0 + 1 }
            .reduce(0, +)
        return risk
    }

    static func Part2(_ data: [String]) -> Int {
        let (grid, lows) = parse(data)

        let basins = lows.map {
            grid.dfs(start: $0) { current in
                [Vector2.left, Vector2.right, Vector2.up, Vector2.down]
                    .map { current + $0 }
                    .filter { grid.get(for: $0) != nil }
            } isValue: { current in
                grid.get(for: current) == 9
            } value: { current in
                0
            } fromValues: { values in
                values.reduce(0, +) + 1
            }
        }.sorted()

        return basins
            .suffix(3)
            .reduce(1, *)
    }

    private static func parse(_ data: [String]) -> (Grid2<Int>, lows: [Vector2]) {
        let values = data.map { $0.map { $0.int }}
        let grid = Grid2(values: values)

        let lows = grid.keys.filter { key in
            guard let value = grid.get(for: key) else { fatalError() }

            let adjacent = [Vector2.left, Vector2.right, Vector2.up, Vector2.down]
                .map { key + $0 }
                .compactMap { grid.get(for: $0) }

            return adjacent
                .filter { $0 > value }
                .count == adjacent.count
        }
        return (grid, lows)
    }
}

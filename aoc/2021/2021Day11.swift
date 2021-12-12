//
//  2021Day11.swift
//  aoc
//
//  Created by Paul U on 12/11/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day11 {

    static func Part0() {
        let data0 = """
11111
19991
19191
19991
11111
""".newlineSplit()
        let values0 = data0.map { $0.map { $0.int }}
        let grid0 = Grid2(values: values0)
        // After step 1
        let data1 = """
34543
40004
50005
40004
34543
""".newlineSplit()
        let values1 = data1.map { $0.map { $0.int }}
        let grid1 = Grid2(values: values1)
        assert(grid0.step().0 == grid1)
        assert(grid0.step().1 == 9)
        // After step 2
        let data2 = """
45654
51115
61116
51115
45654
""".newlineSplit()
        let values2 = data2.map { $0.map { $0.int }}
        let grid2 = Grid2(values: values2)
        assert(grid1.step().0 == grid2)
        assert(grid1.step().1 == 0)
    }

    static func Part1(_ data: [String]) -> Int {
        let values = data.map { $0.map { $0.int }}
        var grid = Grid2(values: values)
        var total = 0
        for _ in 0..<100 {
            let (copy, count) = grid.step()
            grid = copy
            total += count
        }

        return total
    }

    static func Part2(_ data: [String]) -> Int {
        let values = data.map { $0.map { $0.int }}
        var grid = Grid2(values: values)
        var step = 1
        while true {
            let (copy, count) = grid.step()
            grid = copy
            if count == 100 {
                return step
            }
            step += 1
        }
    }
}

private extension Grid2 where T == Int {
    func step() -> (Grid2, Int) {
        var copy = self
        var flashes = Set<Vector2>()
        var flashed = Set<Vector2>()
        copy.tuples.forEach {
            let value = $0.value + 1
            copy.set(for: $0.key, value: value)
            if value > 9 {
                flashes.insert($0.key)
            }
        }
        while !flashes.isEmpty {
            let flash = flashes.removeFirst()
            flashed.insert(flash)
            [Vector2.n, .nw, .ne, .s, .sw, .se, .w, .e]
                .map { flash + $0 }
                .forEach {
                    guard var value = copy.get(for: $0) else { return }
                    value += 1
                    copy.set(for: $0, value: value)
                    if value > 9 && !flashed.contains($0) {
                        flashes.insert($0)
                    }
                }
        }
        flashed.forEach {
            copy.set(for: $0, value: 0)
        }
        return (copy, flashed.count)
    }
}

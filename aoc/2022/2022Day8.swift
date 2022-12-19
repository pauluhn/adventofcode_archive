//
// Copyright © 2022 Paul Uhn. All rights reserved.
//

import Foundation

struct Y2022Day8 {
    typealias Grid = Grid2<Tree>
    struct Tree {
        let value: Int
        var visible = false
    }

    static func Part1(_ data: [String]) -> Int {
        var grid = parse(data)
        var current: Vector2?

        // L to R
        for y in grid.minY...grid.maxY {
            current = nil
            for x in grid.minX...grid.maxX {
                compute1(&grid, x, y, &current)
            }
        }

        // R to L
        for y in grid.minY...grid.maxY {
            current = nil
            for x in (grid.minX...grid.maxX).reversed() {
                compute1(&grid, x, y, &current)
            }
        }

        // U to D
        for x in grid.minX...grid.maxX {
            current = nil
            for y in grid.minY...grid.maxY {
                compute1(&grid, x, y, &current)
            }
        }

        // D to U
        for x in grid.minX...grid.maxX {
            current = nil
            for y in (grid.minY...grid.maxY).reversed() {
                compute1(&grid, x, y, &current)
            }
        }

        let answer = grid.values
            .filter { $0.visible }
            .count
        return answer
    }

    static func Part2(_ data: [String]) -> Int {
        let grid = parse(data)
        var highest = 0

        for current in grid.keys {
            var product = 1
            var count = 0

            // L to R
            for x in current.x...grid.maxX where current != Vector2(x: x, y: current.y) {
                count += 1
                if !compute2(grid, x, current.y, current) {
                    break
                }
            }
            product *= count

            // R to L
            count = 0
            for x in (grid.minX...current.x).reversed() where current != Vector2(x: x, y: current.y) {
                count += 1
                if !compute2(grid, x, current.y, current) {
                    break
                }
            }
            product *= count

            // U to D
            count = 0
            for y in current.y...grid.maxY where current != Vector2(x: current.x, y: y) {
                count += 1
                if !compute2(grid, current.x, y, current) {
                    break
                }
            }
            product *= count

            // D to U
            count = 0
            for y in (grid.minY...current.y).reversed() where current != Vector2(x: current.x, y: y) {
                count += 1
                if !compute2(grid, current.x, y, current) {
                    break
                }
            }
            product *= count
            highest = max(highest, product)
        }
        return highest
    }

    private static func compute1(_ grid: inout Grid, _ x: Int, _ y: Int, _ current: inout Vector2?) {
        let tree = grid.get(x, y)
        guard let c = current else {
            current = grid.set(x, y, tree.value)
            return
        }
        if tree.value > grid.get(c.x, c.y).value {
            current = grid.set(x, y, tree.value)
        }
    }

    private static func compute2(_ grid: Grid, _ x: Int, _ y: Int, _ current: Vector2) -> Bool {
        let tree = grid.get(x, y)
        return tree.value < grid.get(current.x, current.y).value
    }
}

private extension Grid2 where T == Y2022Day8.Tree {
    typealias Tree = Y2022Day8.Tree
    func get(_ x: Int, _ y: Int) -> Tree {
        get(for: Vector2(x: x, y: y))!
    }
    mutating func set(_ x: Int, _ y: Int, _ value: Int) -> Vector2 {
        let vector = Vector2(x: x, y: y)
        set(for: vector, value: Tree(value: value, visible: true))
        return vector
    }
}

private extension Y2022Day8 {
    static func parse(_ data: [String]) -> Grid {
        let values = data.map { $0.map { Tree(value: $0.int) } }
        let grid = Grid2(values: values)
        return grid
    }
}


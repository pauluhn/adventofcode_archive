//
//  Grid2.swift
//  aoc
//
//  Created by Paul U on 12/9/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

/// 0,0 = top left corner
struct Grid2<T> {

    init(values: [[T]]) {
        for (y, row) in values.enumerated() {
            for (x, value) in row.enumerated() {
                set(for: Vector2(x: x, y: y), value: value)
            }
        }
    }

    private var grid = [Vector2: T]()
    private var minX = 0
    private var maxX = 0
    private var minY = 0
    private var maxY = 0
}

extension Grid2: Equatable where T: Equatable {
    static func == (lhs: Grid2<T>, rhs: Grid2<T>) -> Bool {
        guard lhs.minX == rhs.minX, lhs.maxX == rhs.maxX, lhs.minY == rhs.minY, lhs.maxY == rhs.maxY, lhs.keys.count == rhs.keys.count else { return false }
        return lhs.keys.allSatisfy { key in
            lhs.get(for: key) == rhs.get(for: key)
        }
    }
}

extension Grid2 {

    var keys: [Vector2] { grid.keys.map { $0 }}
    var values: [T] { grid.values.map { $0 }}
    var tuples: [(key: Vector2, value: T)] { grid.map { $0 }}

    func get(for key: Vector2) -> T? { grid[key] }

    mutating func set(for key: Vector2, value: T) {
        grid[key] = value
        minX = min(minX, key.x)
        maxX = max(maxX, key.x)
        minY = min(minY, key.y)
        maxY = max(maxY, key.y)
    }
}

// MARK: - DFS
extension Grid2 {

    typealias NextClosure = (_ current: Vector2) -> [Vector2]
    typealias IsValueClosure = (_ current: Vector2) -> Bool
    typealias ValueClosure = (_ current: Vector2) -> T
    typealias FromValuesClosure = (_ values: [T]) -> T

    /// Depth First Search
    /// - parameters:
    ///   - start: starting root vector2
    ///   - next: given current, return a list of next
    ///   - isValue: given current, return `true` to halt search because: 1) found `T`, 2) is leaf or base
    ///   - value: given current, return `T` when `isValue` is `true`
    ///   - fromValues: given list of `T` from `next`, reduce to a single `T`
    func dfs(start: Vector2, next: NextClosure, isValue: IsValueClosure, value: ValueClosure, fromValues: FromValuesClosure
    ) -> T {
        var visited = Set([start])
        let results = dfs(start, next, isValue, value, fromValues, &visited)
        return results
    }
    private func dfs(_ start: Vector2, _ next: NextClosure, _ isValue: IsValueClosure, _ value: ValueClosure, _ fromValues: FromValuesClosure, _ visited: inout Set<Vector2>
    ) -> T {
        guard !isValue(start) else { return value(start) }

        let toVisit = next(start).filter { !visited.contains($0) }
        visited.formUnion(toVisit)

        let values = toVisit.map { dfs($0, next, isValue, value, fromValues, &visited) }
        return fromValues(values)
    }
}

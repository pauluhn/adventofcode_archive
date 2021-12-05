//
//  2021Day5.swift
//  aoc
//
//  Created by Paul U on 12/4/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day5 {

    static func Part1(_ data: [String]) -> Int {
        count(data)
    }

    static func Part2(_ data: [String]) -> Int {
        count(data, ignoreDiagonals: false)
    }

    private static func count(_ data: [String], ignoreDiagonals: Bool = true) -> Int {
        let lines = data.compactMap(Line.init)

        var points = [Vector2: Int]()
        for line in lines {
            let isNotDiagonal = line.isVertical || line.isHorizontal
            if ignoreDiagonals && !isNotDiagonal { continue }

            for point in line.points {
                points[point, default: 0] += 1
            }
        }
        return points
            .filter { $0.value > 1 }
            .count
    }
}

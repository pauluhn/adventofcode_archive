//
//  Line.swift
//  aoc
//
//  Created by Paul U on 12/5/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Line {

    let start: Vector2
    let end: Vector2

    init(start: Vector2, end: Vector2) {
        self.start = start
        self.end = end
    }
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }

        let x1 = data.match(match, at: 1).int
        let y1 = data.match(match, at: 2).int
        let x2 = data.match(match, at: 3).int
        let y2 = data.match(match, at: 4).int

        start = Vector2(x: x1, y: y1)
        end = Vector2(x: x2, y: y2)
    }

}

extension Line {

    var direction: Vector2 {
        (end - start).normalized
    }

    var isHorizontal: Bool {
        direction == .left || direction == .right
    }

    var isVertical: Bool {
        direction == .up || direction == .down
    }

    /// Returns every `Vector2` along the line segment
    var points: [Vector2] {
        var points = [Vector2]()

        let offset = direction
        var point = start

        while point != end {
            points.append(point)
            point += offset
        }
        points.append(end)

        return points
    }
}

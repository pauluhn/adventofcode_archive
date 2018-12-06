//
//  Coord.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Coord {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^(\\d+), (\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        x = data.match(match, at: 1).int
        y = data.match(match, at: 2).int
    }
    
    func manhattanDistance(from other: Coord) -> Int {
        return abs(x - other.x) + abs(y - other.y)
    }
}
extension Coord: Hashable {}

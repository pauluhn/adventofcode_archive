//
//  2020Day11.swift
//  aoc
//
//  Created by Paul U on 12/12/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day11 {

    enum Tile: Character {
        case floor = "."
        case seat = "L"
        case occupied = "#"
    }
    enum Direction: CaseIterable {
        case n, s, e, w, nw, ne, se, sw
    }
    
    struct Map {
        private(set) var map: [[Tile]]
        init(_ data: [String]) {
            map = data
                .map { $0.compactMap(Tile.init) }
                .filter { !$0.isEmpty }
        }
        func tile(at point: Point) -> Tile? {
            guard 0 <= point.x, point.x < map[0].count,
                  0 <= point.y, point.y < map.count else { return nil }
            return map[point.y][point.x]
        }
        func adjacent(to point: Point) -> Int {
            return Direction.allCases
                .map { point.offset(in: $0) }
                .compactMap { tile(at: $0) }
                .filter { $0 == .occupied }
                .count
        }
        mutating func update(map: [[Tile]]) {
            self.map = map
        }
    }

    static func Part1(_ data: [String]) -> Int {
        var map = Map(data)
        var round = 0
        
        while true {
            print("\nRound: \(round)")
            map.print()
            
            var cache = map.map
            for (y, row) in map.map.enumerated() {
                for (x, tile) in row.enumerated() where tile != .floor {
                    let count = map.adjacent(to: Point(x: x, y: y))
                    
                    if tile == .seat && count == 0 {
                        cache[y][x] = .occupied
                    
                    } else if tile == .occupied && count >= 4 {
                        cache[y][x] = .seat
                    }
                }
            }
            if map.map == cache {
                break
            }
            map.update(map: cache)
            round += 1
        }
        
        return map.map
            .flatMap { $0 }
            .filter { $0 == .occupied }
            .count
    }
}

private extension Point {
    func offset(in direction: Y2020Day11.Direction) -> Point {
        switch direction {
        case .n:  return Point(x: x,     y: y - 1)
        case .s:  return Point(x: x,     y: y + 1)
        case .e:  return Point(x: x - 1, y: y)
        case .w:  return Point(x: x + 1, y: y)
        case .nw: return Point(x: x + 1, y: y - 1)
        case .ne: return Point(x: x - 1, y: y - 1)
        case .se: return Point(x: x - 1, y: y + 1)
        case .sw: return Point(x: x + 1, y: y + 1)
        }
    }
}
private extension Y2020Day11.Map {
    func print() {
        let printable = map
            .map { $0.map { $0.rawValue }}
            .map { String($0) }
            .reduce("") { $0 + $1 + "\n" }
        Swift.print(printable)
    }
}

//
//  2020Day3.swift
//  aoc
//
//  Created by Paul U on 12/3/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day3 {
    
    struct Map {
        enum Tile: Character {
            case open = "."
            case tree = "#"
        }
        
        private let tiles: [[Tile]]
        private let width: Int
        let height: Int
        
        init(_ data: [String]) {
            tiles = data.compactMap { row in
                let tiles = row.map { Tile(rawValue: $0)! }
                return tiles.isEmpty ? nil : tiles
            }
            width = tiles.first?.count ?? 0
            height = tiles.count
            
        }
        
        func location(_ point: Point) -> Tile {
            let x = point.x % width
            let y = point.y
            return tiles[y][x]
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        let map = Map(data)
        let slope = Point(x: 3, y: 1)

        var position = Point.zero
        var count = 0
        while position.y < map.height {
            let tile = map.location(position)
            switch tile {
            case .open: break
            case .tree: count += 1
            }
            position += slope
        }
        return count
    }
}

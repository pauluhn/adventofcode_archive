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
    
    static func trees(map: Map, slope: Point) -> Int {
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
    
    static func Part1(_ data: [String]) -> Int {
        let map = Map(data)
        let slope = Point(x: 3, y: 1)
        return trees(map: map, slope: slope)
    }
    
    static func Part2(_ data: [String]) -> Int {
        let map = Map(data)
        let slopes = [
            Point(x: 1, y: 1),
            Point(x: 3, y: 1),
            Point(x: 5, y: 1),
            Point(x: 7, y: 1),
            Point(x: 1, y: 2)
        ]
        let product = slopes
            .map { trees(map: map, slope: $0) }
            .reduce(1, *)
        return product
    }
}

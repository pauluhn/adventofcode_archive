//
//  2018Day10.swift
//  aoc
//
//  Created by Paul Uhn on 12/10/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day10 {
    static func Part1(_ data: [String], _ seconds: Int) -> (message: String, seconds: Int) {
        assert(StarAlign("position=< 9,  1> velocity=< 0,  2>")!.description == "position=<9,1> velocity=<0,2>")
        assert(StarAlign("position=< 6, 10> velocity=<-2, -1>")!.description == "position=<6,10> velocity=<-2,-1>")
        assert(StarAlign("position=< 21518, -21209> velocity=<-2,  2>")!.description == "position=<21518,-21209> velocity=<-2,2>")
        assert(StarAlign("position=<-21158, -21218> velocity=< 2,  2>")!.description == "position=<-21158,-21218> velocity=<2,2>")
        
        let stars = data.compactMap(StarAlign.init)
        
        // find min/max
        var minX: Int!
        var maxX: Int!
        var minY: Int!
        var maxY: Int!

        // map positions
        var mapSize = Int.max
        var positions: [Point]!
        var previousPositions: [Point]!

        for s in 0..<seconds {
            positions = []
            (minX, maxX, minY, maxY) = (Int.max, Int.min, Int.max, Int.min)
            
            for star in stars {
                let position = star.position(after: s)
                positions.append(position)
                (minX, maxX, minY, maxY) = (min(minX, position.x), max(maxX, position.x), min(minY, position.y), max(maxY, position.y))
            }
            let width = maxX - minX + 1
            let height = maxY - minY + 1
            let newSize = width * height
            
            if newSize < mapSize {
                mapSize = newSize
                previousPositions = positions
            } else {
                return (printMap(previousPositions), s - 1)
            }
        }
        fatalError("Stars need more time!")
    }
}
private extension Y2018Day10 {
    static func printMap(_ positions: [Point]) -> String {
        let minX = positions.sorted { $0.x < $1.x }.first.map { $0.x }!
        let maxX = positions.sorted { $0.x > $1.x }.first.map { $0.x }!
        let minY = positions.sorted { $0.y < $1.y }.first.map { $0.y }!
        let maxY = positions.sorted { $0.y > $1.y }.first.map { $0.y }!
        let offsetX = -minX
        let offsetY = -minY
        
        var map = Array(repeating: Array(repeating: ".", count: maxX + offsetX + 1), count: maxY + offsetY + 1)
        for position in positions {
            map[position.y + offsetY][position.x + offsetX] = "#"
        }
        return map.reduce("") { r, x in r + x.reduce("", +) + "\n" }
    }
}

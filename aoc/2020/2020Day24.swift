//
//  2020Day24.swift
//  aoc
//
//  Created by Paul U on 12/23/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day24 {
    
    enum Direction: String {
        case e
        case se
        case sw
        case w
        case nw
        case ne
    }
    
    struct TileDirections {
        private(set) var directions = [Direction]()
        
        init?(_ data: String) {
            guard !data.isEmpty else { return nil }
            var previous: String?
            for d in data {
                switch d {
                case "s":
                    previous = "s"
                case "n":
                    previous = "n"
                case "e":
                    switch previous {
                    case "s": directions.append(.se)
                    case "n": directions.append(.ne)
                    case nil: directions.append(.e)
                    default: fatalError()
                    }
                    previous = nil
                case "w":
                    switch previous {
                    case "s": directions.append(.sw)
                    case "n": directions.append(.nw)
                    case nil: directions.append(.w)
                    default: fatalError()
                    }
                    previous = nil
                default: fatalError()
                }
            }
        }
    }

    static func Part1(_ data: [String]) -> Int {
        let data = data.compactMap(TileDirections.init)
        
        var set = Set<Point>()
        for td in data {
            var point = Point.zero
            for d in td.directions {
                point = point.move(in: d)
            }
            
            if set.contains(point) {
                set.remove(point)
            } else {
                set.insert(point)
            }
        }
        return set.count
    }
}

private extension Point {
    func move(in direction: Y2020Day24.Direction) -> Point {
        switch direction {
        case .e: return offset(by: 2, 0)
        case .se: return offset(by: 1, 1)
        case .sw: return offset(by: -1, 1)
        case .w: return offset(by: -2, 0)
        case .nw: return offset(by: -1, -1)
        case .ne: return offset(by: 1, -1)
        }
    }
}


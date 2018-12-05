//
//  Rect.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Rect {
    let id: Int
    let origin: Coord
    let size: Size
    
    var minX: Int { return origin.x }
    var minY: Int { return origin.y }
    var maxX: Int { return origin.x + size.width - 1 }
    var maxY: Int { return origin.y + size.height - 1 }
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        id = data.match(match, at: 1).int
        origin = Coord(x: data.match(match, at: 2).int,
                       y: data.match(match, at: 3).int)
        size = Size(width: data.match(match, at: 4).int,
                    height: data.match(match, at: 5).int)
    }
    
    func intersects(_ other: Rect) -> Bool {
        return !(maxX < other.minX || other.maxX < minX || maxY < other.minY || other.maxY < minY)
    }
}
extension Rect: CustomStringConvertible {
    var description: String {
        return "#\(id) @ \(origin.x),\(origin.y): \(size.width)x\(size.height)"
    }
}

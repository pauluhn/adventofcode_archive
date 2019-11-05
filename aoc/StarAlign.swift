//
//  StarAlign.swift
//  aoc
//
//  Created by Paul Uhn on 12/10/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct StarAlign {
    typealias Velocity = Point

    let position: Point
    let velocity: Velocity
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^position=<(.+)> velocity=<(.+)>$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        position = Point(data.match(match, at: 1))!
        velocity = Velocity(data.match(match, at: 2))!
    }
    
    func position(after seconds: Int) -> Point {
        return Point(x: position.x + velocity.x * seconds, y: position.y + velocity.y * seconds)
    }
}
extension StarAlign: CustomStringConvertible {
    var description: String {
        return "position=<\(position)> velocity=<\(velocity)>"
    }
}

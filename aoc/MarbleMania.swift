//
//  MarbleMania.swift
//  aoc
//
//  Created by Paul Uhn on 12/9/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct MarbleMania {
    let playerCount: Int
    let lastMarblePoint: Int
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^(\\d+) players; last marble is worth (\\d+) points$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        playerCount = data.match(match, at: 1).int
        lastMarblePoint = data.match(match, at: 2).int
    }
}
extension MarbleMania: CustomStringConvertible {
    var description: String {
        return "\(playerCount) players; last marble is worth \(lastMarblePoint) points"
    }
}

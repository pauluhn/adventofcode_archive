//
//  Instruction.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Instruction {
    let parent: String
    let child: String
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^Step ([A-Z]+) must be finished before step ([A-Z]+) can begin\\.$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        parent = data.match(match, at: 1)
        child = data.match(match, at: 2)
    }
}
extension Instruction: CustomStringConvertible {
    var description: String {
        return "Step \(parent) must be finished before step \(child) can begin."
    }
}

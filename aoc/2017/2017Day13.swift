//
//  2017Day13.swift
//  aoc
//
//  Created by Paul Uhn on 11/23/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day13 {

    struct Scanner {
        let depth: Int
        let range: Int
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^(\\d+): (\\d+)")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            
            depth = data.match(match, at: 1).int
            range = data.match(match, at: 2).int
        }
        
        func position(at picoseconds: Int) -> Int {
            let magic = (range - 1) * 2
            var index = picoseconds % magic
            if index >= range {
                index = magic - index
            }
            return index
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        assert(Scanner("0: 3")!.position(at: 0) == 0)
        assert(Scanner("0: 3")!.position(at: 1) == 1)
        assert(Scanner("0: 3")!.position(at: 2) == 2)
        assert(Scanner("0: 3")!.position(at: 3) == 1)
        assert(Scanner("0: 3")!.position(at: 4) == 0)
        assert(Scanner("0: 3")!.position(at: 5) == 1)
        assert(Scanner("0: 2")!.position(at: 0) == 0)
        assert(Scanner("0: 2")!.position(at: 1) == 1)
        assert(Scanner("0: 2")!.position(at: 2) == 0)
        assert(Scanner("0: 2")!.position(at: 3) == 1)
        assert(Scanner("0: 2")!.position(at: 4) == 0)
        assert(Scanner("0: 2")!.position(at: 5) == 1)
        assert(Scanner("0: 4")!.position(at: 0) == 0)
        assert(Scanner("0: 4")!.position(at: 1) == 1)
        assert(Scanner("0: 4")!.position(at: 2) == 2)
        assert(Scanner("0: 4")!.position(at: 3) == 3)
        assert(Scanner("0: 4")!.position(at: 4) == 2)
        assert(Scanner("0: 4")!.position(at: 5) == 1)
        assert(Scanner("0: 4")!.position(at: 6) == 0)
        assert(Scanner("0: 4")!.position(at: 7) == 1)
        
        let scanners = data.compactMap(Scanner.init)
        
        var severity = 0
        for scanner in scanners {
            let depth = scanner.depth
            let caught = scanner.position(at: depth) == 0
            if caught {
                severity += depth * scanner.range
            }
        }
        return severity
    }
}

//
//  2020Day13.swift
//  aoc
//
//  Created by Paul U on 12/13/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day13 {

    static func Part1(_ data: [String]) -> Int {
        guard data.count >= 2 else { fatalError() }
        let timestamp = data[0].int
        let bus = data[1].buses
            .filter { $0 > 0 } // remove x
            .map { ($0, $0 - (timestamp % $0)) }
            .min { $0.1 < $1.1 }!
        return bus.0 * bus.1
    }
    
    static func Part2(_ data: [String]) -> Int {
        guard data.count >= 2 else { fatalError() }
        
        var buses = [CRT.Input]()
        for (n, id) in data[1].buses.enumerated() where id > 0 /* ignore x */ {
            buses += [CRT.Input(remainder: id - n, mod: id)]
        }
        let output = CRT(inputs: buses).compute()
        return output
    }
}

private extension String {
    var buses: [Int] {
        return self
            .split(separator: ",")
            .map { $0.str.int }
    }
}

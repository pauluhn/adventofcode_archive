//
//  2020Day25.swift
//  aoc
//
//  Created by Paul U on 12/25/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day25 {

    static func Part1(_ pk1: Int, _ pk2: Int) -> Int {
        let sn = 7
        let mod = 20201227

        var value = 1
        var loopSize = 0
        while value != pk1 {
            value = (value * sn) % mod
            loopSize += 1
        }

        var ek = 1
        for _ in 0 ..< loopSize {
            ek = (ek * pk2) % mod
        }
        return ek
    }
}

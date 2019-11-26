//
//  2017Day17.swift
//  aoc
//
//  Created by Paul Uhn on 11/25/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day17 {

    static func Part1(_ steps: Int) -> Int {
        let spinlock = CircularList<Int>()
        spinlock.append(0)
        var currentPosition = spinlock.head!
        
        while spinlock.count <= 2017 {
            currentPosition = spinlock.get(currentPosition, offset: steps)
            let next = spinlock.count
            spinlock.insert(after: currentPosition, next)
            currentPosition = spinlock.get(currentPosition, offset: 1)
        }
        return spinlock.get(currentPosition, offset: 1).value
    }
}

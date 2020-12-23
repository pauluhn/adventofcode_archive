//
//  2020Day23.swift
//  aoc
//
//  Created by Paul U on 12/23/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day23 {

    static func Part1(_ data: String, _ moves: Int) -> String {
        let cups = CircularList<Int>()
        data.forEach { cups.append($0.int) }
        
        var current = cups.head!
        
        for m in 0 ..< moves {

            // pick up
            let removed = (1 ... 3)
                .map { cups.get(current, offset: $0) }
                .map { cups.remove($0) }

            // select destination
            var destination = current
            var n = current
            var found = false
            if current.value > 1 {
                for d in (1 ... current.value - 1).reversed() where !found {
                    n = n.next!
                    while n.value != current.value && !found {
                        if n.value == d {
                            found = true
                            destination = n
                        }
                        n = n.next!
                    }
                }
            }
            if !found {
                for d in (current.value + 1 ..< 10).reversed() where !found{
                    n = n.next!
                    while n.value != current.value && !found {
                        if n.value == d {
                            found = true
                            destination = n
                        }
                        n = n.next!
                    }
                }
            }
            guard found else { fatalError() }

            // places
            var d = destination
            for r in removed {
                cups.insert(after: d, r)
                d = d.next!
            }

            // select current
            current = current.next!            
        }

        while current.value != 1 {
            current = current.next!
        }
        current = current.next!
        return (0 ..< 8)
            .map { cups.get(current, offset: $0) }
            .map { $0.value.str }
            .joined()
    }
}


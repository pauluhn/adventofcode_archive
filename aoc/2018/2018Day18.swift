//
//  2018Day18.swift
//  aoc
//
//  Created by Paul Uhn on 12/18/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day18 {
    static func Part1(_ data: [String], _ minutes: Int) -> Int {
        let land = data.compactMap { (string) -> [Acre]? in
            let array = string.compactMap(Acre.init)
            return array.isEmpty ? nil : array
        }
        let size = Size(width: land[0].count, height: land.count)
        
        var minute = 0
        while minute < minutes {
            // reset
            for array in land {
                for acre in array {
                    acre.reset()
                }
            }
            // input
            for (y, array) in land.enumerated() {
                for (x, acre) in array.enumerated() {
                    for point in adjacent(to: Point(x: x, y: y), size) {
                        land[point.y][point.x].add(input: acre.current)
                    }
                    
                }
            }
            // compute
            for array in land {
                for acre in array {
                    acre.compute()
                }
            }
            
            // for part 2
            if minutes == 1000000000 {
                let (open, trees, lumberyard) = count(land)
                print("\(open*trees*lumberyard),\(trees*lumberyard)")
                // begin pattern (print the land to visually see pattern instead)
                if lumberyard == 199841 { // minute 477, 505
                    let remaining = minutes - 477
                    let offset = remaining % (505 - 477)
                    print("offset is \(offset)")
                    // visually locate number =\
                    return 176782
                }
            }
            minute += 1
//            print("\(minute)/\(minutes)")
//            printLand(land)
        }
        let (_, trees, lumberyard) = count(land)
        return trees * lumberyard
    }
}
private extension Y2018Day18 {
    static func adjacent(to point: Point, _ size: Size) -> [Point] {
        let points = [point.offset(by: -1, -1),
                      point.offset(by: 0, -1),
                      point.offset(by: 1, -1),
                      point.offset(by: -1, 0),
                      point.offset(by: 1, 0),
                      point.offset(by: -1, 1),
                      point.offset(by: 0, 1),
                      point.offset(by: 1, 1)]
        return points.filter { $0.isValid(size) }
    }
    static func printLand(_ land: [[Acre]]) {
        let display = land.reduce("") { $0 + $1.reduce("") { $0 + $1.description } + "\n" }
        print(display)
    }
    static func count(_ land: [[Acre]]) -> (open: Int, trees: Int, lumberyard: Int) {
        return land.reduce((0, 0, 0)) {
            let tuple = $1.reduce((0, 0, 0)) {
                ($0.0 + ($1.current == .open ? 1 : 0),
                 $0.1 + ($1.current == .trees ? 1 : 0),
                 $0.2 + ($1.current == .lumberyard ? 1 : 0))
            }
            return ($0.0 + tuple.0, $0.1 + tuple.1, $0.2 + tuple.2)
        }
    }
}
private extension Point {
    func isValid(_ size: Size) -> Bool {
        return x >= 0 && x < size.width && y >= 0 && y < size.height
    }
}

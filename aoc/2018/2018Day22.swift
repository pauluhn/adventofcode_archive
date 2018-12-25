//
//  2018Day22.swift
//  aoc
//
//  Created by Paul Uhn on 12/24/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day22 {
    static func Part1(_ depth: Int, _ x: Int, _ y: Int) -> Int {
        let cave = computeCave(depth, x, y)
        printCave(cave)
        return riskLevel(cave)
    }
}
private struct Region {
    let depth: Int
    let geologicIndex: Int
    let erosionLevel: Int
    enum RegionType: Int {
        case rocky
        case wet
        case narrow
        case mouth
        case target
    }
    let type: RegionType
    let special: RegionType?
    init(_ depth: Int, _ geologicIndex: Int) {
        self.depth = depth
        self.geologicIndex = geologicIndex
        erosionLevel = (geologicIndex + depth) % 20183
        type = RegionType(rawValue: erosionLevel % 3)!
        special = nil
    }
    init(_ depth: Int, _ special: RegionType) {
        self.depth = depth
        geologicIndex = 0
        erosionLevel = (geologicIndex + depth) % 20183
        type = RegionType(rawValue: erosionLevel % 3)!
        self.special = special
    }
}
private extension Y2018Day22 {
    static func computeCave(_ depth: Int, _ targetX: Int, _ targetY: Int, _ padding: Int = 0) -> [[Region]] {
        var cave = [[Region]]()
        for y in 0..<targetY + padding + 1 {
            cave.append([])
            for x in 0..<targetX + padding + 1 {
                switch (x, y) {
                case (0, 0):
                    cave[y].append(Region(depth, .mouth))
                case (targetX, targetY):
                    cave[y].append(Region(depth, .target))
                case (0, _):
                    cave[y].append(Region(depth, y * 48271))
                case (_, 0):
                    cave[y].append(Region(depth, x * 16807))
                default:
                    let geologicIndex = cave[y][x - 1].erosionLevel * cave[y - 1][x].erosionLevel
                    cave[y].append(Region(depth, geologicIndex))
                }
            }
        }
        return cave
    }
    static func printCave(_ cave: [[Region]]) {
        let display = cave.reduce("") { $0 + $1.reduce("") { "\($0)\($1)" } + "\n" }
        print(display)
    }
    static func riskLevel(_ cave: [[Region]]) -> Int {
        return cave.reduce(0) { $0 + $1.reduce(0) { $0 + $1.type.rawValue }}
    }
}
extension Region: CustomStringConvertible {
    var description: String {
        return special?.description ?? type.description
    }
}
extension Region.RegionType: CustomStringConvertible {
    var description: String {
        switch self {
        case .rocky: return "."
        case .wet: return "="
        case .narrow: return "|"
        case .mouth: return "M"
        case .target: return "T"
        }
    }
}

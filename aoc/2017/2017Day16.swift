//
//  2017Day16.swift
//  aoc
//
//  Created by Paul Uhn on 11/25/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day16 {
    
    enum Move {
        case spin(size: Int)
        case exchange(Int, Int)
        case partner(String, String)
    }

    static func Part1(_ programs: String, _ data: String) -> String {
        return dance(programs, moves(data))
    }
    
    static func Part2(_ programs: String, _ data: String) -> String {
        let m = moves(data)
        var programs = programs
        
        var pattern = [programs]
        var unique = Set(pattern)
        
        for i in 0 ..< 1_000_000_000 {
            programs = dance(programs, m)
            if unique.contains(programs) {
                print("detected pattern at \(i)")
                let offset = 1_000_000_000 % pattern.count
                return pattern[offset]
            } else {
                pattern.append(programs)
                unique.insert(programs)
            }
        }
        return programs
    }
    
    private static func moves(_ data: String) -> [Move] {
        return data
            .split(separator: ",")
            .map(String.init)
            .map { move($0) }
    }
    
    private static func dance(_ programs: String, _ moves: [Move]) -> String {
        var programs = programs.map(String.init)
        moves.forEach {
            programs.apply($0)
        }
        return programs.joined()
    }
    
    private static func move(_ data: String) -> Move {
        switch data.first! {
        case "s":
            return .spin(size: data.dropFirst().int)
        case "x":
            let two = data.dropFirst().split(separator: "/")
            return .exchange(two.first!.int, two.last!.int)
        case "p":
            let two = data.dropFirst().split(separator: "/")
            return .partner(two.first!.str, two.last!.str)
        default:
            fatalError()
        }
    }
}

private extension Array where Element == String {
    mutating func apply(_ move: Y2017Day16.Move) {
        switch move {
            
        case .spin(let size):
            for _ in 0..<size {
                let item = removeLast()
                insert(item, at: 0)
            }
            
        case let .exchange(x, y):
            let item = self[x]
            self[x] = self[y]
            self[y] = item
            
        case let .partner(x, y):
            var i = 0
            var j = 0
            for z in 0..<count {
                if self[z] == x { i = z }
                if self[z] == y { j = z }
            }
            let item = self[i]
            self[i] = self[j]
            self[j] = item
        }
    }
}

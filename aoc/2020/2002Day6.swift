//
//  2002Day6.swift
//  aoc
//
//  Created by Paul U on 12/6/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day6 {
    
    static func Part1(_ data: String) -> Int {
        return data
            .components(separatedBy: "\n\n")
            .map { group -> Int in
                let answers = group.compactMap { answer -> Character? in
                    switch answer {
                    case "a"..."z": return answer
                    default: return nil
                    }
                }
                return Set(answers).count
            }
            .reduce(0, +)
    }
    
    static func Part2(_ data: String) -> Int {
        return data
            .components(separatedBy: "\n\n")
            .map { group -> Int in
                let persons = group
                    .components(separatedBy: .whitespacesAndNewlines)
                    .filter { !$0.isEmpty }
                let answers = persons.flatMap { $0 }
                return NSCountedSet(array: answers)
                    .count(of: persons.count)
                    .count
            }
            .reduce(0, +)
    }
}

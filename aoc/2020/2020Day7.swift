//
//  2020Day7.swift
//  aoc
//
//  Created by Paul U on 12/7/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day7 {
    typealias Bag = String
    
    struct Rule {
        let bag: Bag
        let contains: [Bag: Int]
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([a-z ]+) bags contain ([0-9a-z, ]+)\\.$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            bag = data.match(match, at: 1)
            let otherBags = data.match(match, at: 2)
            if otherBags == "no other bags" {
                contains = [:]
            } else {
                contains = otherBags
                    .split(separator: ",")
                    .map { $0.trimmingCharacters(in: .whitespaces) }
                    .filter { !$0.isEmpty }
                    .compactMap { Rule.parse($0) }
                    .reduce(into: [:]) { $0[$1.1] = $1.0 }
            }
        }
        private static func parse(_ data: String) -> (Int, Bag)? {
            let regex = try! NSRegularExpression(pattern: "^([0-9]+) ([a-z ]+) bags?$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            let count = data.match(match, at: 1).int
            let bag = data.match(match, at: 2)
            return (count, bag)
        }
    }
    
    static func Part1(_ data: [String]) -> Int {
        let rules = data.compactMap(Rule.init)
        
        var bags = ["shiny gold"]
        var seen = Set<Bag>()
        
        while !bags.isEmpty {
            let bag = bags.removeFirst()
            if seen.contains(bag) { continue }
            seen.insert(bag)
            
            let next = rules
                .filter { $0.contains.contains { $0.0 == bag } }
                .map { $0.bag }
            bags += next
        }
        return seen.count - 1
    }
    static func Part2(_ data: [String]) -> Int {
        let rules = data.compactMap(Rule.init)
        
        var bags = ["shiny gold"]
        var count = 0
        
        while !bags.isEmpty {
            let bag = bags.removeFirst()
            count += 1
            
            let next = rules
                .first(where: { $0.bag == bag })
                .flatMap { $0.contains.flatMap { Array(repeating: $0.key, count: $0.value) } }
            bags += next!
        }
        return count - 1
    }
}

//
//  2020Day16.swift
//  aoc
//
//  Created by Paul U on 12/16/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day16 {

    struct Field: Equatable {
        let name: String
        let range1: Range<Int>
        let range2: Range<Int>
        var index: Int?
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([a-z ]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            name = data.match(match, at: 1)
            let min1 = data.match(match, at: 2).int
            let max1 = data.match(match, at: 3).int
            range1 = min1 ..< max1 + 1
            let min2 = data.match(match, at: 4).int
            let max2 = data.match(match, at: 5).int
            range2 = min2 ..< max2 + 1
        }
    }
    
    struct Ticket {
        let values: [Int]
        let count: Int
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([0-9,]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            values = data.match(match, at: 1)
                .split(separator: ",")
                .map { $0.str.int }
            count = values.count
        }
    }
    
    static func parse(_ data: String) -> ([Field], Ticket, [Ticket], [Set<Int>], Set<Int>) {
        let data = data.components(separatedBy: "\n\n")
        guard data.count == 3 else { fatalError() }
        
        let fields = data[0]
            .components(separatedBy: .newlines)
            .compactMap(Field.init)
        let mine = data[1]
            .components(separatedBy: .newlines)
            .compactMap(Ticket.init)
            .first!
        let nearby = data[2]
            .components(separatedBy: .newlines)
            .compactMap(Ticket.init)

        let fieldSets = fields
            .map { field -> Set<Int> in
                Set<Int>()
                    .union(field.range1)
                    .union(field.range2)
            }
        
        let fieldSet = fieldSets
            .reduce(into: Set<Int>()) {
                $0.formUnion($1)
            }
        
        return (fields, mine, nearby, fieldSets, fieldSet)
    }
    
    static func Part1(_ data: String) -> Int {
        let (_, _, nearby, _, fieldSet) = parse(data)
        
        return nearby
            .flatMap { $0.values }
            .filter { !fieldSet.contains($0) }
            .reduce(0, +)
    }
    
    static func Part2(_ data: String, _ prefix: String) -> Int {
        let (fields, mine, nearby, fieldSets, fieldSet) = parse(data)
        // find valid tickets
        let valid = nearby
            .filter {
                $0.values
                    .filter { !fieldSet.contains($0) } // invalid
                    .isEmpty
            }
        // group values by index
        let values = { valid -> [[Int]] in
            var values = Array(repeating: [Int](), count: fields.count)
            for ticket in valid {
                for (n, v) in ticket.values.enumerated() {
                    values[n] += [v]
                }
            }
            return values
        }(valid)
        // match field sets to grouped values
        let matched = fieldSets
            .map { set -> [Int] in
                var matching = [Int]()
                for (n, v) in values.enumerated() {
                    let s = Set(v)
                    if s.intersection(set).count == s.count {
                        matching += [n]
                    }
                }
                return matching
            }
        // sort and zip field to grouped indexes
        let sorted = zip(fields, matched)
            .sorted { $0.1.count < $1.1.count }
        // determine field index
        var used = Set<Int>()
        var final = fields
        for (field, indexes) in sorted {
            let matching = Set(indexes).subtracting(used)
            guard matching.count == 1,
                  let first = matching.first else { fatalError() }
            
            used.insert(first)
            guard let index = final.firstIndex(where: { $0 == field }) else { fatalError() }
            final[index].index = first
        }
        // multiply
        var product = 1
        for field in final where field.name.hasPrefix(prefix) {
            guard let index = field.index else { fatalError() }
            product *= mine.values[index]
        }
        return product
    }
}

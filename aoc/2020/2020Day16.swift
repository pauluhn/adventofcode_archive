//
//  2020Day16.swift
//  aoc
//
//  Created by Paul U on 12/16/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day16 {

    struct Field {
        let name: String
        let range1: Range<Int>
        let range2: Range<Int>
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([a-z]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$")
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
    
    static func Part1(_ data: String) -> Int {
        let data = data.components(separatedBy: "\n\n")
        guard data.count == 3 else { fatalError() }
        
        let fields = data[0]
            .components(separatedBy: .newlines)
            .compactMap(Field.init)
        let nearby = data[2]
            .components(separatedBy: .newlines)
            .compactMap(Ticket.init)
        
        var fieldSet = Set<Int>()
        fields
            .flatMap { [$0.range1, $0.range2] }
            .forEach { fieldSet.formUnion($0) }

        return nearby
            .flatMap { $0.values }
            .filter { !fieldSet.contains($0) }
            .reduce(0, +)
    }
}

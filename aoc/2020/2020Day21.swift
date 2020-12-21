//
//  2020Day21.swift
//  aoc
//
//  Created by Paul U on 12/21/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day21 {

    struct Food {
        let ingredients: [String]
        let allergens: [String]
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([a-z ]+) \\(contains ([a-z, ]+)\\)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            ingredients = data.match(match, at: 1).components(separatedBy: " ")
            allergens = data.match(match, at: 2).components(separatedBy: ", ")
        }
    }
    
    private static func compute(_ data: [String]) -> ([Food], [String: String]) {
        let data = data.compactMap(Food.init)
        var table = [String: String]()
        // allergens
        let allergens = data.flatMap { $0.allergens }
        let allergenSet = NSCountedSet(array: allergens)
        var allergenSorted = allergenSet.sorted() as! [String]
        while !allergenSorted.isEmpty {
            let allergen = allergenSorted.removeFirst()
            let food = data.filter { $0.allergens.contains(allergen) }
            let ingredientSet = food.map { Set($0.ingredients) }
            var ingredient = ingredientSet.first!
            for set in ingredientSet {
                ingredient = ingredient.intersection(set)
            }
            ingredient.subtract(table.values)
            guard ingredient.count == 1 else {
                allergenSorted.append(allergen)
                continue
            }
            table[allergen] = ingredient.first
        }
        return (data, table)
    }
    
    static func Part1(_ data: [String]) -> Int {
        let (data, table) = compute(data)
        // ingredients
        let ingredients = data.flatMap { $0.ingredients }
        let count =  ingredients
            .filter { !table.values.contains($0) }
            .count
        return count
    }

    static func Part2(_ data: [String]) -> String {
        let (_, table) = compute(data)
        return table.map { ($0.key, $0.value) }
            .sorted { $0.0 < $1.0 }
            .map { $0.1 }
            .joined(separator: ",")
    }
}

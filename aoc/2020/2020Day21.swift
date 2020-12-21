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
    
    static func Part1(_ data: [String]) -> Int {
        let data = data.compactMap(Food.init)
        var known = [String]()
        // allergens
        let allergens = data.flatMap { $0.allergens }
        let allergenSet = NSCountedSet(array: allergens)
        let allergenSorted = allergenSet.sorted() as! [String]
        
        for allergen in allergenSorted {
            let food = data.filter { $0.allergens.contains(allergen) }
            let ingredientSet = food.map { Set($0.ingredients) }
            var ingredient = ingredientSet.first!
            for set in ingredientSet {
                ingredient = ingredient.intersection(set)
            }
            ingredient.subtract(known)
            known += ingredient.map { $0 }
        }
        // ingredients
        let ingredients = data.flatMap { $0.ingredients }
        let count =  ingredients
            .filter { !known.contains($0) }
            .count
        return count
    }
}

//
//  2018Day14.swift
//  aoc
//
//  Created by Paul Uhn on 12/14/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day14 {
    static func Part1(_ startingRecipes: [Int], _ elves: Int, _ interations: Int, _ answerLength: Int) -> String {
        let recipes = CircularList<Int>()
        for recipe in startingRecipes {
            recipes.append(recipe)
        }
        
        let head = recipes.head!
        var makers = [CircularList<Int>.CircularListNode<Int>]()
        for offset in 0..<elves {
            makers.append(recipes.get(head, offset: offset))
        }
        
        while recipes.count < interations + answerLength {
            for recipe in sum(makers) {
                recipes.append(recipe)
            }
            
            for (index, maker) in makers.enumerated() {
                let value = maker.value
                makers[index] = recipes.get(maker, offset: value + 1)
            }
        }
        
        let results = answer1(recipes, interations, answerLength)
        return results
    }
    static func Part2(_ startingRecipes: [Int], _ elves: Int, _ recipeKey: String) -> Int {
        let recipes = CircularList<Int>()
        for recipe in startingRecipes {
            recipes.append(recipe)
        }
        
        let head = recipes.head!
        var makers = [CircularList<Int>.CircularListNode<Int>]()
        for offset in 0..<elves {
            makers.append(recipes.get(head, offset: offset))
        }
        
        while true {
            let newRecipes = sum(makers)
            for recipe in newRecipes {
                recipes.append(recipe)
            }
            
            // check for recipe key
            if let answer = answer2(recipes, recipeKey) {
                return answer
            }

            for (index, maker) in makers.enumerated() {
                let value = maker.value
                makers[index] = recipes.get(maker, offset: value + 1)
            }
        }
        fatalError()
    }
}
private extension Y2018Day14 {
    static func sum(_ makers: [CircularList<Int>.CircularListNode<Int>]) -> [Int] {
        let value = makers.reduce(0) { $0 + $1.value }
        if value < 10 {
            return [value]
        } else {
            return [1, value % 10]
        }
    }
    static func answer1(_ recipes: CircularList<Int>, _ interations: Int, _ answerLength: Int) -> String {
        var node = recipes.head!
        for _ in 0..<interations {
            node = node.next!
        }
        
        var values = [Int]()
        for offset in 0..<answerLength {
            values.append(recipes.get(node, offset: offset).value)
        }
        return values.reduce("") { $0 + String($1) }
    }
    static func answer2(_ recipes: CircularList<Int>, _ recipeKey: String) -> Int? {
        let node = recipes.last!
        var values = [Int]()
        for offset in 0...recipeKey.count {
            values.append(recipes.get(node, offset: -offset).value)
        }
        
        let possible = values.reversed().reduce("") { $0 + String($1) }
        if possible.prefix(recipeKey.count) == recipeKey {
            return recipes.count - recipeKey.count - 1
        } else if possible.suffix(recipeKey.count) == recipeKey {
            return recipes.count - recipeKey.count
        }
        return nil
    }
}

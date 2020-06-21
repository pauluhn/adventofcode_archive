//
//  DungeonGame.swift
//  aocTests
//
//  Created by Paul Uhn on 6/21/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class Solution {
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        let maxRow = dungeon.count
        let maxCol = dungeon.first?.count ?? 0
        let nodes = dungeon.map { $0.map(Node.init) }
        
        let knight = nodes[0][0]
        let princess = nodes[maxRow - 1][maxCol - 1]
        
        var links = [Link]()
        for (row, n) in nodes.enumerated() {
            for (col, node) in n.enumerated() {
                // right
                if col < maxCol - 1 {
                    links.append(Link(from: node, to: nodes[row][col + 1]))
                }
                // down
                if row < maxRow - 1 {
                    links.append(Link(from: node, to: nodes[row + 1][col]))
                }
            }
        }
        
        
        return 0
    }
}

private struct Node {
    let val: Int
}

private struct Link {
    let from: Node
    let to: Node
}

class DungeonGameTests: XCTestCase {
    func testCase1() {
        let dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
        let answer = Solution().calculateMinimumHP(dungeon)
        assert(answer == 7)
    }
}

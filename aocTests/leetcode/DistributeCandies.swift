//
//  DistributeCandies.swift
//  aocTests
//
//  Created by Paul Uhn on 5/29/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class Solution {
    // given constraints
    // sister can get at most `candies.count / 2` kinds of candies
    func distributeCandies(_ candies: [Int]) -> Int {
        let set = Set(candies)
        return min(set.count, candies.count / 2)
    }
}

class DistributeCandiesTests: XCTestCase {
    func testCase1() {
        let candies = [1,1,2,2,3,3]
        let answer = Solution().distributeCandies(candies)
        assert(answer == 3)
    }
    func testCase2() {
        let candies = [1,1,2,3]
        let answer = Solution().distributeCandies(candies)
        assert(answer == 2)
    }
}

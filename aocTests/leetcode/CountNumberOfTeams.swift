//
//  CountNumberOfTeams.swift
//  aocTests
//
//  Created by Paul Uhn on 7/10/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class Solution {
    func numTeams(_ rating: [Int]) -> Int {
        guard rating.count > 2 else { return 0 }
        var i = 0
        var count = 0
        
        // first
        while i < rating.count - 2 {
            let first = rating[i]
            var j = i + 1

            // second
            while j < rating.count - 1 {
                let second = rating[j]
                var k = j + 1
                
                let order = first < second
                
                // third
                while k < rating.count {
                    let third = rating[k]
                    
                    switch (order, second < third) {
                    case (true, true),
                         (false, false):
                        count += 1
                        
                    default:
                        break
                    }
                    k += 1
                }
                j += 1
            }
            i += 1
        }
        return count
    }
}

class CountNumberOfTeamsTests: XCTestCase {
    func testCase1() {
        let answer = Solution().numTeams([2,5,3,4,1])
        assert(answer == 3)
    }
    func testCase2() {
        let answer = Solution().numTeams([2,1,3])
        assert(answer == 0)
    }
    func testCase3() {
        let answer = Solution().numTeams([1,2,3,4])
        assert(answer == 4)
    }
}

//
//  TwoCityScheduling.swift
//  aocTests
//
//  Created by Paul Uhn on 6/3/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class Solution {
    // initial thought around solution is:
    // "normalize" the data by subtracting the lowest cost from both cities. that will make one zero and the other a positive difference.
    // sort each into a city bucket and only do the shuffling if N is not even.
    // for shuffling, we'll need a slightly different structure so that we can sort by lowest difference. and move enough from one city to the other until even
    
    struct Cost {
        let A: Int
        let B: Int
        private(set) var _A: Int
        private(set) var _B: Int
        init(_ cost: [Int]) {
            guard cost.count == 2 else { fatalError() }
            _A = cost[0]
            _B = cost[1]
            let lowest = min(_A, _B)
            A = _A - lowest
            B = _B - lowest
        }
    }
    
    func twoCitySchedCost(_ costs: [[Int]]) -> Int {
        var A = [Cost]()
        var B = [Cost]()

        for cost in costs.map(Cost.init) {
            if cost.A == 0 {
                A.append(cost)
            } else if cost.B == 0 {
                B.append(cost)
            } else {
                fatalError()
            }
        }
        A.sort { $0.B > $1.B }
        B.sort { $0.A > $1.A }

        while A.count != B.count {
            if A.count < B.count {
                A.append(B.popLast()!)
            } else {
                B.append(A.popLast()!)
            }
        }
        return
            A.reduce(0) { $0 + $1._A } +
            B.reduce(0) { $0 + $1._B }
    }
}

class TwoCitySchedulingTests: XCTestCase {
    func testCase1() {
        let costs = [[10,20],[30,200],[400,50],[30,20]]
        let answer = Solution().twoCitySchedCost(costs)
        assert(answer == 110)
    }
    func testCase2() {
        let costs = [[259,770],[448,54],[926,667],[184,139],[840,118],[577,469]]
        let answer = Solution().twoCitySchedCost(costs)
        assert(answer == 1859)
    }
}

//
//  aoc2017Tests.swift
//  aocTests
//
//  Created by Paul Uhn on 11/4/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2017Tests: XCTestCase {
    private var year = 2017

    func testDay8Part1() {
        let testData1 = testDataDay8Part1()
        assert(Y2017Day8.Part1(testData1.newlineSplit()) == 1)
        
        let answer = Y2017Day8.Part1(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 3612)
    }
}

extension aoc2017Tests {
    func testDataDay8Part1() -> String {
        return """
        b inc 5 if a > 1
        a inc 1 if b < 5
        c dec -10 if a >= 1
        c inc -20 if c == 10
        """
    }
}

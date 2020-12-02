//
//  aoc2020Tests.swift
//  aocTests
//
//  Created by Paul U on 12/1/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2020Tests: XCTestCase {
    private var year = 2020

    func testDay1Part1() {
        let testData1 = testDataDay1().newlineSplit()
        assert(Y2020Day1.Part1(testData1) == 514579)
        
        let answer = Y2020Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 840324)
    }
    func testDay1Part2() {
        let testData1 = testDataDay1().newlineSplit()
        assert(Y2020Day1.Part2(testData1) == 241861950)
        
        let answer = Y2020Day1.Part2(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 170098110)
    }
    func testDay2Part1() {
        let testData1 = testDataDay2().newlineSplit()
        assert(Y2020Day2.Part1(testData1) == 2)
        
        let answer = Y2020Day2.Part1(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 445)
    }

}

extension aoc2020Tests {
    func testDataDay1() -> String {
        return """
            1721
            979
            366
            299
            675
            1456
            """
    }
    func testDataDay2() -> String {
        return """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""
    }
}

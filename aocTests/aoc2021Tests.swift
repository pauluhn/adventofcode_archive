//
//  aoc2021Tests.swift
//  aocTests
//
//  Created by Paul U on 12/1/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2021Tests: XCTestCase {
    private let year = 2021

    func testDay1Part1() {
        let testData1 = testDataDay1().newlineSplit()
        assert(Y2021Day1.Part1(testData1) == 7)

        let answer = Y2021Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 1655)
    }
    func testDay1Part2() {
        let testData1 = testDataDay1().newlineSplit()
        assert(Y2021Day1.Part2(testData1) == 5)

        let answer = Y2021Day1.Part2(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 1683)
    }
    func testDay2Part1() {
        let testData1 = testDataDay2().newlineSplit()
        assert(Y2021Day2.Part1(testData1) == 150)

        let answer = Y2021Day2.Part1(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 1989265)
    }
    func testDay2Part2() {
        let testData1 = testDataDay2().newlineSplit()
        assert(Y2021Day2.Part2(testData1) == 900)

        let answer = Y2021Day2.Part2(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 2089174012)
    }
}

extension aoc2021Tests {
    func testDataDay1() -> String {
        return """
199
200
208
210
200
207
240
269
260
263
"""
    }
    func testDataDay2() -> String {
        return """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""
    }
}

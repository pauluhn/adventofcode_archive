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
}

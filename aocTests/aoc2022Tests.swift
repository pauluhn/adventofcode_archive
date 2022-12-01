//
//  aoc2022Tests.swift
//  aocTests
//
//  Created by Paul U on 11/30/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import XCTest
@testable import aoc

final class aoc2022Tests: XCTestCase {
    private let year = 2022

    func testDay1Part1() {
        let testData1 = testDataDay1()
        assert(Y2022Day1.Part1(testData1) == 24000)

        let answer = Y2022Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 69836)
    }

    func testDay1Part2() {
        let testData1 = testDataDay1()
        assert(Y2022Day1.Part2(testData1) == 45000)

        let answer = Y2022Day1.Part2(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 207968)
    }
}

extension aoc2022Tests {
    func testDataDay1() -> String {
        return """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""
    }
}

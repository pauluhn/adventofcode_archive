//
//  aoc2019Tests.swift
//  aocTests
//
//  Created by Paul Uhn on 12/1/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2019Tests: XCTestCase {
    private var year = 2019

    func testDay1Part1() {
        assert(Y2019Day1.Part1(["12"]) == 2)
        assert(Y2019Day1.Part1(["14"]) == 2)
        assert(Y2019Day1.Part1(["1969"]) == 654)
        assert(Y2019Day1.Part1(["100756"]) == 33583)

        let answer = Y2019Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 3390830)
    }

    func testDay1Part2() {
        assert(Y2019Day1.Part2(["14"]) == 2)
        assert(Y2019Day1.Part2(["1969"]) == 966)
        assert(Y2019Day1.Part2(["100756"]) == 50346)
        
        let answer = Y2019Day1.Part2(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 5083370)
    }
}

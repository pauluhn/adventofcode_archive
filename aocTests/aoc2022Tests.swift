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

    func testDay2Part1() {
        let testData1 = testDataDay2().newlineSplit()
        assert(Y2022Day2.Part1(testData1) == 15)

        let answer = Y2022Day2.Part1(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 13675)
    }

    func testDay2Part2() {
        let testData1 = testDataDay2().newlineSplit()
        assert(Y2022Day2.Part2(testData1) == 12)

        let answer = Y2022Day2.Part2(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 14184)
    }

    func testDay3Part1() {
        let testData1 = testDataDay3().newlineSplit()
        assert(Y2022Day3.Part1(testData1) == 157)

        let answer = Y2022Day3.Part1(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 7746)
    }

    func testDay3Part2() {
        let testData1 = testDataDay3().newlineSplit()
        assert(Y2022Day3.Part2(testData1) == 70)

        let answer = Y2022Day3.Part2(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 2604)
    }

    func testDay4Part1() {
        let testData1 = testDataDay4().newlineSplit()
        assert(Y2022Day4.Part1(testData1) == 2)

        let answer = Y2022Day4.Part1(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 644)
    }

    func testDay4Part2() {
        let testData1 = testDataDay4().newlineSplit()
        assert(Y2022Day4.Part2(testData1) == 4)

        let answer = Y2022Day4.Part2(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 926)
    }

    func testDay5Part1() {
        let testData1 = testDataDay5().newlineSplit()
        assert(Y2022Day5.Part1(testData1) == "CMZ")

        let answer = Y2022Day5.Part1(readInput(year: year, day: 5))
        print("\(#function):\(answer)")
        assert(answer == "FJSRQCFTN")
    }

    func testDay5Part2() {
        let testData1 = testDataDay5().newlineSplit()
        assert(Y2022Day5.Part2(testData1) == "MCD")

        let answer = Y2022Day5.Part2(readInput(year: year, day: 5))
        print("\(#function):\(answer)")
        assert(answer == "CJVLJQPHS")
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
    func testDataDay2() -> String {
        return """
A Y
B X
C Z
"""
    }
    func testDataDay3() -> String {
        return """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""
    }
    func testDataDay4() -> String {
        return """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""
    }
    func testDataDay5() -> String {
        return """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
    }
}

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
    func testDay3Part1() {
        let testData1 = testDataDay3().newlineSplit()
        assert(Y2021Day3.Part1(testData1) == 198)

        let answer = Y2021Day3.Part1(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 4001724)
    }
    func testDay3Part2() {
        let testData1 = testDataDay3().newlineSplit()
        assert(Y2021Day3.Part2(testData1) == 230)

        let answer = Y2021Day3.Part2(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 587895)
    }
    func testDay4Part1() {
        let testData1 = testDataDay4().newlineSplit()
        assert(Y2021Day4.Part1(testData1) == 4512)

        let answer = Y2021Day4.Part1(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 49860)
    }
    func testDay4Part2() {
        let testData1 = testDataDay4().newlineSplit()
        assert(Y2021Day4.Part2(testData1) == 1924)

        let answer = Y2021Day4.Part2(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 24628)
    }
    func testDay5Part1() {
        let testData1 = testDataDay5().newlineSplit()
        assert(Y2021Day5.Part1(testData1) == 5)

        let answer = Y2021Day5.Part1(readInput(year: year, day: 5))
        print("\(#function):\(answer)")
        assert(answer == 5585)
    }
    func testDay5Part2() {
        let testData1 = testDataDay5().newlineSplit()
        assert(Y2021Day5.Part2(testData1) == 12)

        let answer = Y2021Day5.Part2(readInput(year: year, day: 5))
        print("\(#function):\(answer)")
        assert(answer == 17193)
    }
    func testDay6Part1() {
        let testData1 = testDataDay6().commaSplit()
        assert(Y2021Day6.Part1(testData1, days: 18) == 26)
        assert(Y2021Day6.Part1(testData1) == 5934)

        let answer = Y2021Day6.Part1(readInput(year: year, day: 6).commaSplit())
        print("\(#function):\(answer)")
        assert(answer == 388419)
    }
    func testDay6Part2() {
        let testData1 = testDataDay6().commaSplit()
        assert(Y2021Day6.Part2(testData1) == 26984457539)

        let answer = Y2021Day6.Part2(readInput(year: year, day: 6).commaSplit())
        print("\(#function):\(answer)")
        assert(answer == 1740449478328)
    }
    func testDay7Part1() {
        let testData1 = testDataDay7().commaSplit()
        assert(Y2021Day7.Part1(testData1) == 37)

        let answer = Y2021Day7.Part1(readInput(year: year, day: 7).commaSplit())
        print("\(#function):\(answer)")
        assert(answer == 352997)
    }
    func testDay7Part2() {
        let testData1 = testDataDay7().commaSplit()
        assert(Y2021Day7.Part2(testData1) == 168)

        let answer = Y2021Day7.Part2(readInput(year: year, day: 7).commaSplit())
        print("\(#function):\(answer)")
        assert(answer == 101571302)
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
    func testDataDay3() -> String {
        return """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""
    }
    func testDataDay4() -> String {
        return """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""
    }
    func testDataDay5() -> String {
        return """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
    }
    func testDataDay6() -> String {
        return "3,4,3,1,2"
    }
    func testDataDay7() -> String {
        return "16,1,2,0,4,2,7,1,2,14"
    }
}

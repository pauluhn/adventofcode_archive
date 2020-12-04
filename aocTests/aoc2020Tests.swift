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
    func testDay2Part2() {
        let testData1 = testDataDay2().newlineSplit()
        assert(Y2020Day2.Part2(testData1) == 1)
        
        let answer = Y2020Day2.Part2(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 491)
    }
    func testDay3Part1() {
        let testData1 = testDataDay3().newlineSplit()
        assert(Y2020Day3.Part1(testData1) == 7)
        
        let answer = Y2020Day3.Part1(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 191)
    }
    func testDay3Part2() {
        let testData1 = testDataDay3().newlineSplit()
        assert(Y2020Day3.Part2(testData1) == 336)
        
        let answer = Y2020Day3.Part2(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 1478615040)
    }
    func testDay4Part1() {
        let testData1 = testDataDay4().newlineSplit()
        assert(Y2020Day4.Part1(testData1) == 2)
        
        let answer = Y2020Day4.Part1(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 226)
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
    func testDataDay3() -> String {
        return """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""
    }
    func testDataDay4() -> String {
        return """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in

"""
    }
}

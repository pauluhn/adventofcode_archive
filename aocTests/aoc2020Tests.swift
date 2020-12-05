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
        let testData1 = testDataDay4a().newlineSplit()
        assert(Y2020Day4.Part1(testData1) == 2)
        
        let answer = Y2020Day4.Part1(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 226)
    }
    func testDay4Part2() {
        let testData1 = testDataDay4b().newlineSplit()
        assert(Y2020Day4.Part2(testData1) == 0)
        
        let testData2 = testDataDay4c().newlineSplit()
        assert(Y2020Day4.Part2(testData2) == 4)
        
        let answer = Y2020Day4.Part2(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 160)
    }
    func testDay5Part1() {
        assert(Y2020Day5.Part1(["FBFBBFFRLR"]) == 357)
        assert(Y2020Day5.Part1(["BFFFBBFRRR"]) == 567)
        assert(Y2020Day5.Part1(["FFFBBBFRRR"]) == 119)
        assert(Y2020Day5.Part1(["BBFFBBFRLL"]) == 820)

        let answer = Y2020Day5.Part1(readInput(year: year, day: 5))
        print("\(#function):\(answer)")
        assert(answer == 998)
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
    func testDataDay4a() -> String {
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
    func testDataDay4b() -> String {
        return """
eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007

"""
    }
    func testDataDay4c() -> String {
        return """
pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719

"""
    }
}

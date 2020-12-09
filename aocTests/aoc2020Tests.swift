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
        let testData1 = testDataDay4a()
        assert(Y2020Day4.Part1(testData1) == 2)
        
        let answer = Y2020Day4.Part1(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 226)
    }
    func testDay4Part2() {
        let testData1 = testDataDay4b()
        assert(Y2020Day4.Part2(testData1) == 0)
        
        let testData2 = testDataDay4c()
        assert(Y2020Day4.Part2(testData2) == 4)
        
        let answer = Y2020Day4.Part2(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 160)
    }
    func testDay5Part1() {
        assert(Y2020Day5.Part1(["FBFBBFFRLR"]).max()! == 357)
        assert(Y2020Day5.Part1(["BFFFBBFRRR"]).max()! == 567)
        assert(Y2020Day5.Part1(["FFFBBBFRRR"]).max()! == 119)
        assert(Y2020Day5.Part1(["BBFFBBFRLL"]).max()! == 820)

        let answer = Y2020Day5.Part1(readInput(year: year, day: 5)).max()!
        print("\(#function):\(answer)")
        assert(answer == 998)
    }
    func testDay5Part2() {
        let answer = Y2020Day5.Part2(readInput(year: year, day: 5))
        print("\(#function):\(answer)")
        assert(answer == 676)
    }
    func testDay6Part1() {
        let testData1 = testDataDay6a()
        assert(Y2020Day6.Part1(testData1) == 6)
        let testData2 = testDataDay6b()
        assert(Y2020Day6.Part1(testData2) == 11)

        let answer = Y2020Day6.Part1(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 6911)
    }
    func testDay6Part2() {
        let testData1 = testDataDay6b()
        assert(Y2020Day6.Part2(testData1) == 6)

        let answer = Y2020Day6.Part2(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 3473)
    }
    func testDay7Part1() {
        let testData1 = testDataDay7a().newlineSplit()
        assert(Y2020Day7.Part1(testData1) == 4)

        let answer = Y2020Day7.Part1(readInput(year: year, day: 7))
        print("\(#function):\(answer)")
        assert(answer == 226)
    }
    func testDay7Part2() {
        let testData1 = testDataDay7a().newlineSplit()
        assert(Y2020Day7.Part2(testData1) == 32)
        let testData2 = testDataDay7b().newlineSplit()
        assert(Y2020Day7.Part2(testData2) == 126)

        let answer = Y2020Day7.Part2(readInput(year: year, day: 7))
        print("\(#function):\(answer)")
        assert(answer == 9569)
    }
    func testDay8Part1() {
        let testData1 = testDataDay8().newlineSplit()
        assert(Y2020Day8.Part1(testData1) == 5)

        let answer = Y2020Day8.Part1(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 1548)
    }
    func testDay8Part2() {
        let testData1 = testDataDay8().newlineSplit()
        assert(Y2020Day8.Part2(testData1) == 8)

        let answer = Y2020Day8.Part2(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 1375)
    }
    func testDay9Part1() {
        var preamble = (1...25).map { $0 }
        assert(Y2020Day9.Part1(preamble + [26], 25) == 0)
        assert(Y2020Day9.Part1(preamble + [49], 25) == 0)
        assert(Y2020Day9.Part1(preamble + [100], 25) == 100)
        assert(Y2020Day9.Part1(preamble + [50], 25) == 50)
        
        preamble = preamble.filter { $0 != 20 } + [45]
        assert(Y2020Day9.Part1(preamble + [26], 25) == 0)
        assert(Y2020Day9.Part1(preamble + [65], 25) == 65)
        assert(Y2020Day9.Part1(preamble + [64], 25) == 0)
        assert(Y2020Day9.Part1(preamble + [66], 25) == 0)

        let testData1 = testDataDay9().newlineSplit()
        assert(Y2020Day9.Part1(testData1, 5) == 127)

        let answer = Y2020Day9.Part1(readInput(year: year, day: 9), 25)
        print("\(#function):\(answer)")
        assert(answer == 731031916)
    }
    func testDay9Part2() { // ~10s
        let testData1 = testDataDay9().newlineSplit()
        assert(Y2020Day9.Part2(testData1, 5) == 62)

        let answer = Y2020Day9.Part2(readInput(year: year, day: 9), 25)
        print("\(#function):\(answer)")
        assert(answer == 93396727)
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
    func testDataDay6a() -> String {
        return """
abcx
abcy
abcz

"""
    }
    func testDataDay6b() -> String {
        return """
abc

a
b
c

ab
ac

a
a
a
a

b

"""
    }
    func testDataDay7a() -> String {
        return """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
    }
    func testDataDay7b() -> String {
        return """
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"""
    }
    func testDataDay8() -> String {
        return """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""
    }
    func testDataDay9() -> String {
        return """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""
    }
}

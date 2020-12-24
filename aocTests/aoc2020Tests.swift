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
    func testDay9Part2() {
        let testData1 = testDataDay9().newlineSplit()
        assert(Y2020Day9.Part2(testData1, 5) == 62)

        let answer = Y2020Day9.Part2(readInput(year: year, day: 9), 25)
        print("\(#function):\(answer)")
        assert(answer == 93396727)
    }
    func testDay10Part1() {
        let testData1 = testDataDay10a().newlineSplit()
        assert(Y2020Day10.Part1(testData1) == 7 * 5)
        let testData2 = testDataDay10b().newlineSplit()
        assert(Y2020Day10.Part1(testData2) == 22 * 10)

        let answer = Y2020Day10.Part1(readInput(year: year, day: 10))
        print("\(#function):\(answer)")
        assert(answer == 2040)
    }
    func testDay10Part2() {
        let testData1 = testDataDay10a().newlineSplit()
        assert(Y2020Day10.Part2(testData1) == 8)
        let testData2 = testDataDay10b().newlineSplit()
        assert(Y2020Day10.Part2(testData2) == 19208)

        let answer = Y2020Day10.Part2(readInput(year: year, day: 10))
        print("\(#function):\(answer)")
        assert(answer == 28346956187648)
    }
    func testDay11Part1() { // ~6s
        let testData1 = testDataDay11().newlineSplit()
        assert(Y2020Day11.Part1(testData1) == 37)

        let answer = Y2020Day11.Part1(readInput(year: year, day: 11))
        print("\(#function):\(answer)")
        assert(answer == 2338)
    }
    func testDay11Part2() { // ~5s
        let testData1 = testDataDay11().newlineSplit()
        assert(Y2020Day11.Part2(testData1) == 26)

        let answer = Y2020Day11.Part2(readInput(year: year, day: 11))
        print("\(#function):\(answer)")
        assert(answer == 2134)
    }
    func testDay12Part1() {
        let testData1 = testDataDay12().newlineSplit()
        assert(Y2020Day12.Part1(testData1) == 25)

        let answer = Y2020Day12.Part1(readInput(year: year, day: 12))
        print("\(#function):\(answer)")
        assert(answer == 2879)
    }
    func testDay12Part2() {
        let testData1 = testDataDay12().newlineSplit()
        assert(Y2020Day12.Part2(testData1) == 286)

        let answer = Y2020Day12.Part2(readInput(year: year, day: 12))
        print("\(#function):\(answer)")
        assert(answer == 178986)
    }
    func testDay13Part1() {
        let testData1 = testDataDay13().newlineSplit()
        assert(Y2020Day13.Part1(testData1) == 295)

        let answer = Y2020Day13.Part1(readInput(year: year, day: 13))
        print("\(#function):\(answer)")
        assert(answer == 4938)
    }
    func testDay13Part2() {
        // 3 (mod 5), 1 (mod 7), 6 (mod 8)
        let inputs = [(3, 5), (1, 7), (6, 8)]
        assert(CRT(inputs: inputs).compute() == 78)
        
        let testData1 = testDataDay13().newlineSplit()
        assert(Y2020Day13.Part2(testData1) == 1068781)
        assert(Y2020Day13.Part2(["","17,x,13,19"]) == 3417)
        assert(Y2020Day13.Part2(["","67,7,59,61"]) == 754018)
        assert(Y2020Day13.Part2(["","67,x,7,59,61"]) == 779210)
        assert(Y2020Day13.Part2(["","67,7,x,59,61"]) == 1261476)
        assert(Y2020Day13.Part2(["","1789,37,47,1889"]) == 1202161486)

        let answer = Y2020Day13.Part2(readInput(year: year, day: 13))
        print("\(#function):\(answer)")
        assert(answer == 230903629977901)
    }
    func testDay14Part1() {
        let testData1 = testDataDay14a().newlineSplit()
        assert(Y2020Day14.Part1(testData1) == 165)

        let answer = Y2020Day14.Part1(readInput(year: year, day: 14))
        print("\(#function):\(answer)")
        assert(answer == 9967721333886)
    }
    func testDay14Part2() {
        let testData1 = testDataDay14b().newlineSplit()
        assert(Y2020Day14.Part2(testData1) == 208)

        let answer = Y2020Day14.Part2(readInput(year: year, day: 14))
        print("\(#function):\(answer)")
        assert(answer == 4355897790573)
    }
    func testDay15Part1() {
        assert(Y2020Day15.Part1([0,3,6]) == 436)
        assert(Y2020Day15.Part1([1,3,2]) == 1)
        assert(Y2020Day15.Part1([2,1,3]) == 10)
        assert(Y2020Day15.Part1([1,2,3]) == 27)
        assert(Y2020Day15.Part1([2,3,1]) == 78)
        assert(Y2020Day15.Part1([3,2,1]) == 438)
        assert(Y2020Day15.Part1([3,1,2]) == 1836)

        let answer = Y2020Day15.Part1([1,2,16,19,18,0])
        print("\(#function):\(answer)")
        assert(answer == 536)
    }
    func testDay15Part2() { // all ~3m, final ~28s
        assert(Y2020Day15.Part2([0,3,6]) == 175594)
        assert(Y2020Day15.Part2([1,3,2]) == 2578)
        assert(Y2020Day15.Part2([2,1,3]) == 3544142)
        assert(Y2020Day15.Part2([1,2,3]) == 261214)
        assert(Y2020Day15.Part2([2,3,1]) == 6895259)
        assert(Y2020Day15.Part2([3,2,1]) == 18)
        assert(Y2020Day15.Part2([3,1,2]) == 362)

        let answer = Y2020Day15.Part2([1,2,16,19,18,0])
        print("\(#function):\(answer)")
        assert(answer == 24065124)
    }
    func testDay16Part1() {
        let testData1 = testDataDay16a()
        assert(Y2020Day16.Part1(testData1) == 71)

        let answer = Y2020Day16.Part1(readInput(year: year, day: 16))
        print("\(#function):\(answer)")
        assert(answer == 22000)
    }
    func testDay16Part2() {
        let testData1 = testDataDay16b()
        assert(Y2020Day16.Part2(testData1, "class") == 12)
        assert(Y2020Day16.Part2(testData1, "row") == 11)
        assert(Y2020Day16.Part2(testData1, "seat") == 13)

        let answer = Y2020Day16.Part2(readInput(year: year, day: 16), "departure")
        print("\(#function):\(answer)")
        assert(answer == 410460648673)
    }
    func testDay17Part1() {
        let testData1 = testDataDay17().newlineSplit()
        assert(Y2020Day17.Part1(testData1) == 112)

        let answer = Y2020Day17.Part1(readInput(year: year, day: 17))
        print("\(#function):\(answer)")
        assert(answer == 276)
    }
    func testDay17Part2() {
        let testData1 = testDataDay17().newlineSplit()
        assert(Y2020Day17.Part2(testData1) == 848)

        let answer = Y2020Day17.Part2(readInput(year: year, day: 17))
        print("\(#function):\(answer)")
        assert(answer == 2136)
    }
    func testDay18Part1() {
        assert(Y2020Day18.Part1(["1 + 2 * 3 + 4 * 5 + 6"]) == 71)
        assert(Y2020Day18.Part1(["1 + (2 * 3) + (4 * (5 + 6))"]) == 51)
        assert(Y2020Day18.Part1(["2 * 3 + (4 * 5)"]) == 26)
        assert(Y2020Day18.Part1(["5 + (8 * 3 + 9 + 3 * 4 * 3)"]) == 437)
        assert(Y2020Day18.Part1(["5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"]) == 12240)
        assert(Y2020Day18.Part1(["((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"]) == 13632)

        let answer = Y2020Day18.Part1(readInput(year: year, day: 18))
        print("\(#function):\(answer)")
        assert(answer == 4940631886147)
    }
    func testDay18Part2() {
        assert(Y2020Day18.Part2(["1 + 2 * 3 + 4 * 5 + 6"]) == 231)
        assert(Y2020Day18.Part2(["1 + (2 * 3) + (4 * (5 + 6))"]) == 51)
        assert(Y2020Day18.Part2(["2 * 3 + (4 * 5)"]) == 46)
        assert(Y2020Day18.Part2(["5 + (8 * 3 + 9 + 3 * 4 * 3)"]) == 1445)
        assert(Y2020Day18.Part2(["5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"]) == 669060)
        assert(Y2020Day18.Part2(["((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"]) == 23340)

        let answer = Y2020Day18.Part2(readInput(year: year, day: 18))
        print("\(#function):\(answer)")
        assert(answer == 283582817678281)
    }
    func testDay19Part1() {
        let testData1 = testDataDay19a()
        assert(Y2020Day19.Part1(testData1) == 2)
        let testData2 = testDataDay19b()
        assert(Y2020Day19.Part1(testData2) == 2)

        let answer = Y2020Day19.Part1(readInput(year: year, day: 19))
        print("\(#function):\(answer)")
        assert(answer == 285)
    }
    func testDay19Part2() {
        // Re-run Part 1
        let testData1 = testDataDay19a()
        assert(Y2020Day19.Part2(testData1) == 2)
        let testData2 = testDataDay19b()
        assert(Y2020Day19.Part2(testData2) == 2)
        let testData3: String = readInput(year: year, day: 19)
        assert(Y2020Day19.Part2(testData3) == 285)

        let testData4 = testDataDay19c()
        assert(Y2020Day19.Part2(testData4) == 3)
        assert(Y2020Day19.Part2(testData4, with: true) == 12)

        let answer = Y2020Day19.Part2(readInput(year: year, day: 19), with: true)
        print("\(#function):\(answer)")
        assert(answer == 412)
    }
    func testDay20Part1() {
        let testData1 = testDataDay20()
        assert(Y2020Day20.Part1(testData1) == 20899048083289)

        let answer = Y2020Day20.Part1(readInput(year: year, day: 20))
        print("\(#function):\(answer)")
        assert(answer == 16192267830719)
    }
    func testDay20Part2() {
        let testData1 = testDataDay20()
        assert(Y2020Day20.Part2(testData1) == 273)

        let answer = Y2020Day20.Part2(readInput(year: year, day: 20))
        print("\(#function):\(answer)")
        assert(answer == 1909)
    }
    func testDay21Part1() {
        let testData1 = testDataDay21().newlineSplit()
        assert(Y2020Day21.Part1(testData1) == 5)

        let answer = Y2020Day21.Part1(readInput(year: year, day: 21))
        print("\(#function):\(answer)")
        assert(answer == 2125)
    }
    func testDay21Part2() {
        let testData1 = testDataDay21().newlineSplit()
        assert(Y2020Day21.Part2(testData1) == "mxmxvkd,sqjhc,fvjkl")

        let answer = Y2020Day21.Part2(readInput(year: year, day: 21))
        print("\(#function):\(answer)")
        assert(answer == "phc,spnd,zmsdzh,pdt,fqqcnm,lsgqf,rjc,lzvh")
    }
    func testDay22Part1() {
        let testData1 = testDataDay22()
        assert(Y2020Day22.Part1(testData1) == 306)

        let answer = Y2020Day22.Part1(readInput(year: year, day: 22))
        print("\(#function):\(answer)")
        assert(answer == 32102)
    }
    func testDay22Part2() {
        let testData1 = testDataDay22()
        assert(Y2020Day22.Part2(testData1) == 291)

        let answer = Y2020Day22.Part2(readInput(year: year, day: 22))
        print("\(#function):\(answer)")
        assert(answer == 34173)
    }
    func testDay23Part1() {
        assert(Y2020Day23.Part1("389125467", 10) == "92658374")
        assert(Y2020Day23.Part1("389125467", 100) == "67384529")

        let answer = Y2020Day23.Part1("469217538", 100)
        print("\(#function):\(answer)")
        assert(answer == "27956483")
    }
    func testDay23Part2() { // ~165s
        assert(Y2020Day23.Part2("389125467") == 149245887792)

        let answer = Y2020Day23.Part2("469217538")
        print("\(#function):\(answer)")
        assert(answer == 18930983775)
    }
    func testDay24Part1() {
        let testData1 = testDataDay24().newlineSplit()
        assert(Y2020Day24.Part1(testData1) == 10)

        let answer = Y2020Day24.Part1(readInput(year: year, day: 24))
        print("\(#function):\(answer)")
        assert(answer == 263)
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
    func testDataDay10a() -> String {
        return """
16
10
15
5
1
11
7
19
6
12
4
"""
    }
    func testDataDay10b() -> String {
        return """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""
    }
    func testDataDay11() -> String {
        return """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""
    }
    func testDataDay12() -> String {
        return """
F10
N3
F7
R90
F11
"""
    }
    func testDataDay13() -> String {
        return """
939
7,13,x,x,59,x,31,19

"""
    }
    func testDataDay14a() -> String {
        return """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"""
    }
    func testDataDay14b() -> String {
        return """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""
    }
    func testDataDay16a() -> String {
        return """
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
"""
    }
    func testDataDay16b() -> String {
        return """
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
"""
    }
    func testDataDay17() -> String {
        return """
.#.
..#
###

"""
    }
    func testDataDay19a() -> String {
        return """
0: 1 2
1: "a"
2: 1 3 | 3 1
3: "b"

aab
aba
aaa
bbb
"""
    }
    func testDataDay19b() -> String {
        return """
0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"

ababbb
bababa
abbbab
aaabbb
aaaabbb
"""
    }
    func testDataDay19c() -> String {
        return """
42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1

abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
"""
    }
    func testDataDay20() -> String {
        return """
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...

"""
    }
    func testDataDay21() -> String {
        return """
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)

"""
    }
    func testDataDay22() -> String {
        return """
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10

"""
    }
    func testDataDay24() -> String {
        return """
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew

"""
    }
}

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

    func testDay6Part1() {
        let testData1 = testDataDay6a()
        assert(Y2022Day6.Part1(testData1) == 7)
        let testData2 = testDataDay6b()
        assert(Y2022Day6.Part1(testData2) == 5)
        let testData3 = testDataDay6c()
        assert(Y2022Day6.Part1(testData3) == 6)
        let testData4 = testDataDay6d()
        assert(Y2022Day6.Part1(testData4) == 10)
        let testData5 = testDataDay6e()
        assert(Y2022Day6.Part1(testData5) == 11)

        let answer = Y2022Day6.Part1(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 1702)
    }

    func testDay6Part2() {
        let testData1 = testDataDay6a()
        assert(Y2022Day6.Part2(testData1) == 19)
        let testData2 = testDataDay6b()
        assert(Y2022Day6.Part2(testData2) == 23)
        let testData3 = testDataDay6c()
        assert(Y2022Day6.Part2(testData3) == 23)
        let testData4 = testDataDay6d()
        assert(Y2022Day6.Part2(testData4) == 29)
        let testData5 = testDataDay6e()
        assert(Y2022Day6.Part2(testData5) == 26)

        let answer = Y2022Day6.Part2(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 3559)
    }

    func testDay7Part1() {
        let testData1 = testDataDay7().newlineSplit()
        assert(Y2022Day7.Part1(testData1) == 95437)

        let answer = Y2022Day7.Part1(readInput(year: year, day: 7))
        print("\(#function):\(answer)")
        assert(answer == 1886043)
    }

    func testDay7Part2() {
        let testData1 = testDataDay7().newlineSplit()
        assert(Y2022Day7.Part2(testData1) == 24933642)

        let answer = Y2022Day7.Part2(readInput(year: year, day: 7))
        print("\(#function):\(answer)")
        assert(answer == 3842121)
    }

    func testDay8Part1() {
        let testData1 = testDataDay8().newlineSplit()
        assert(Y2022Day8.Part1(testData1) == 21)

        let answer = Y2022Day8.Part1(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 1805)
    }

    func testDay8Part2() {
        let testData1 = testDataDay8().newlineSplit()
        assert(Y2022Day8.Part2(testData1) == 8)

        let answer = Y2022Day8.Part2(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 444528)
    }

    func testDay9Part1() {
        let testData1 = testDataDay9a().newlineSplit()
        assert(Y2022Day9.Part1(testData1) == 13)

        let answer = Y2022Day9.Part1(readInput(year: year, day: 9))
        print("\(#function):\(answer)")
        assert(answer == 5960)
    }

    func testDay9Part2() {
        let testData1 = testDataDay9a().newlineSplit()
        assert(Y2022Day9.Part2(testData1) == 1)
        let testData2 = testDataDay9b().newlineSplit()
        assert(Y2022Day9.Part2(testData2) == 36)

        let answer = Y2022Day9.Part2(readInput(year: year, day: 9))
        print("\(#function):\(answer)")
//        assert(answer == 5960)
    }

    func testDay10Part1() {
        let testData1 = testDataDay10a().newlineSplit()
        assert(Y2022Day10.Part0(testData1) == -1)
        let testData2 = testDataDay10b().newlineSplit()
        assert(Y2022Day10.Part1(testData2) == 13140)

        let answer = Y2022Day10.Part1(readInput(year: year, day: 10))
        print("\(#function):\(answer)")
        assert(answer == 17020)
    }

    func testDay10Part2() {
        let testData1 = testDataDay10b().newlineSplit()
        Y2022Day10.Part2(testData1)

        Y2022Day10.Part2(readInput(year: year, day: 10))
    }

    func testDay11Part1() {
        let testData1 = testDataDay11()
        Y2022Day11.Part0(testData1)
        assert(Y2022Day11.Part1(testData1) == 10605)

        let answer = Y2022Day11.Part1(readInput(year: year, day: 11))
        print("\(#function):\(answer)")
        assert(answer == 61503)
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
    func testDataDay6a() -> String {
        return "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
    }
    func testDataDay6b() -> String {
        return "bvwbjplbgvbhsrlpgdmjqwftvncz"
    }
    func testDataDay6c() -> String {
        return "nppdvjthqldpwncqszvftbrmjlhg"
    }
    func testDataDay6d() -> String {
        return "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
    }
    func testDataDay6e() -> String {
        return "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
    }
    func testDataDay7() -> String {
        return """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""
    }
    func testDataDay8() -> String {
        return """
30373
25512
65332
33549
35390
"""
    }
    func testDataDay9a() -> String {
        return """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""
    }
    func testDataDay9b() -> String {
        return """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
"""
    }
    func testDataDay10a() -> String {
        return """
noop
addx 3
addx -5
"""
    }
    func testDataDay10b() -> String {
        return """
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
"""
    }
    func testDataDay11() -> String {
        return """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"""
    }
}

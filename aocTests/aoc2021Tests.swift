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
    func testDay8Part1() {
        let testData1 = testDataDay8().newlineSplit()
        assert(Y2021Day8.Part1(testData1) == 26)

        let answer = Y2021Day8.Part1(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 318)
    }
    func testDay8Part2() {
        let testData1 = testDataDay8().newlineSplit()
        assert(Y2021Day8.Part2(testData1) == 61229)

        let answer = Y2021Day8.Part2(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 996280)
    }
    func testDay9Part1() {
        let testData1 = testDataDay9().newlineSplit()
        assert(Y2021Day9.Part1(testData1) == 15)

        let answer = Y2021Day9.Part1(readInput(year: year, day: 9))
        print("\(#function):\(answer)")
        assert(answer == 425)
    }
    func testDay9Part2() {
        let testData1 = testDataDay9().newlineSplit()
        assert(Y2021Day9.Part2(testData1) == 1134)

        let answer = Y2021Day9.Part2(readInput(year: year, day: 9))
        print("\(#function):\(answer)")
        assert(answer == 1135260)
    }
    func testDay10Part1() {
        let testData1 = testDataDay10().newlineSplit()
        assert(Y2021Day10.Part1(testData1) == 26397)

        let answer = Y2021Day10.Part1(readInput(year: year, day: 10))
        print("\(#function):\(answer)")
        assert(answer == 388713)
    }
    func testDay10Part2() {
        let testData1 = testDataDay10().newlineSplit()
        assert(Y2021Day10.Part2(testData1) == 288957)

        let answer = Y2021Day10.Part2(readInput(year: year, day: 10))
        print("\(#function):\(answer)")
        assert(answer == 3539961434)
    }
    func testDay11Part1() {
        Y2021Day11.Part0()
        let testData1 = testDataDay11().newlineSplit()
        assert(Y2021Day11.Part1(testData1) == 1656)

        let answer = Y2021Day11.Part1(readInput(year: year, day: 11))
        print("\(#function):\(answer)")
        assert(answer == 1613)
    }
    func testDay11Part2() {
        let testData1 = testDataDay11().newlineSplit()
        assert(Y2021Day11.Part2(testData1) == 195)

        let answer = Y2021Day11.Part2(readInput(year: year, day: 11))
        print("\(#function):\(answer)")
        assert(answer == 510)
    }
    func testDay12Part1() {
        let testData1 = testDataDay12a().newlineSplit()
        assert(Y2021Day12.Part1(testData1) == 10)
        let testData2 = testDataDay12b().newlineSplit()
        assert(Y2021Day12.Part1(testData2) == 19)
        let testData3 = testDataDay12c().newlineSplit()
        assert(Y2021Day12.Part1(testData3) == 226)

        let answer = Y2021Day12.Part1(readInput(year: year, day: 12))
        print("\(#function):\(answer)")
        assert(answer == 4912)
    }
    func testDay12Part2() {
        let testData1 = testDataDay12a().newlineSplit()
        assert(Y2021Day12.Part2(testData1) == 36)
        let testData2 = testDataDay12b().newlineSplit()
        assert(Y2021Day12.Part2(testData2) == 103)
        let testData3 = testDataDay12c().newlineSplit()
        assert(Y2021Day12.Part2(testData3) == 3509)

        let answer = Y2021Day12.Part2(readInput(year: year, day: 12))
        print("\(#function):\(answer)")
        assert(answer == 150004)
    }
    func testDay13Part1() {
        let testData1 = testDataDay13().newlineSplit()
        assert(Y2021Day13.Part1(testData1) == 17)

        let answer = Y2021Day13.Part1(readInput(year: year, day: 13))
        print("\(#function):\(answer)")
        assert(answer == 807)
    }
    func testDay13Part2() {
        let answer = Y2021Day13.Part2(readInput(year: year, day: 13))
        print("\(#function):\(answer)")
        assert(answer == "LGHEGUEJ")
    }
    func testDay14Part1() {
        let testData1 = testDataDay14().newlineSplit()
        assert(Y2021Day14.Part1(testData1) == 1588)

        let answer = Y2021Day14.Part1(readInput(year: year, day: 14))
        print("\(#function):\(answer)")
        assert(answer == 2170)
    }
    func testDay14Part2() {
        let testData1 = testDataDay14().newlineSplit()
        assert(Y2021Day14.Part2(testData1) == 2188189693529)

        let answer = Y2021Day14.Part2(readInput(year: year, day: 14))
        print("\(#function):\(answer)")
        assert(answer == 2422444761283)
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
    func testDataDay8() -> String {
        return """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""
    }
    func testDataDay9() -> String {
        return """
2199943210
3987894921
9856789892
8767896789
9899965678
"""
    }
    func testDataDay10() -> String {
        return """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"""
    }
    func testDataDay11() -> String {
        return """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""
    }
    func testDataDay12a() -> String {
        return """
start-A
start-b
A-c
A-b
b-d
A-end
b-end
"""
    }
    func testDataDay12b() -> String {
        return """
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
"""
    }
    func testDataDay12c() -> String {
        return """
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
"""
    }
    func testDataDay13() -> String {
        return """
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
"""
    }
    func testDataDay14() -> String {
        return """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"""
    }
}

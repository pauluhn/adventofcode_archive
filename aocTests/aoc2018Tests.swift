//
//  aoc2018Tests.swift
//  aocTests
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2018Tests: XCTestCase {
    private var year = 2018
    
    func testDay1Part1() {
        let testData1 = "+1, -2, +3, +1".commaSplit()
        let testData2 = "+1, +1, +1".commaSplit()
        let testData3 = "+1, +1, -2".commaSplit()
        let testData4 = "-1, -2, -3".commaSplit()
        assert(Y2018Day1.Part1(testData1) == 3)
        assert(Y2018Day1.Part1(testData2) == 3)
        assert(Y2018Day1.Part1(testData3) == 0)
        assert(Y2018Day1.Part1(testData4) == -6)
        
        let answer = Y2018Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 525)
    }
    func testDay1Part2() {
        let testData1 = "+1, -2, +3, +1".commaSplit()
        let testData2 = "+1, -1".commaSplit()
        let testData3 = "+3, +3, +4, -2, -4".commaSplit()
        let testData4 = "-6, +3, +8, +5, -6".commaSplit()
        let testData5 = "+7, +7, -2, -7, -4".commaSplit()
        assert(Y2018Day1.Part2(testData1) == 2)
        assert(Y2018Day1.Part2(testData2) == 0)
        assert(Y2018Day1.Part2(testData3) == 10)
        assert(Y2018Day1.Part2(testData4) == 5)
        assert(Y2018Day1.Part2(testData5) == 14)
        
        let answer = Y2018Day1.Part2(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 75749)
    }
    func testDay2Part1() {
        let testData1 = testDataDay2Part1()
        assert(Y2018Day2.Part1(testData1.newlineSplit()) == 12)
        
        let answer = Y2018Day2.Part1(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == 6448)
    }
    func testDay2Part2() {
        let testData1 = testDataDay2Part2()
        assert(Y2018Day2.Part2(testData1.newlineSplit()) == "fgij")
        
        let answer = Y2018Day2.Part2(readInput(year: year, day: 2))
        print("\(#function):\(answer)")
        assert(answer == "evsialkqyiurohzpwucngttmf")
    }
    func testDay3Part1() {
        let testData1 = testDataDay3()
        assert(Y2018Day3.Part1(testData1.newlineSplit()) == 4)

        let answer = Y2018Day3.Part1(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 105071)
    }
    func testDay3Part2() {
        let testData1 = testDataDay3()
        assert(Y2018Day3.Part2(testData1.newlineSplit()) == 3)
        
        let answer = Y2018Day3.Part2(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 222)
    }
    func testDay4Part1() {
        let testData1 = testDataDay4()
        assert(Y2018Day4.Part1(testData1.newlineSplit()) == 240)

        let answer = Y2018Day4.Part1(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 38813)
    }
    func testDay4Part2() {
        let testData1 = testDataDay4()
        assert(Y2018Day4.Part2(testData1.newlineSplit()) == 4455)

        let answer = Y2018Day4.Part2(readInput(year: year, day: 4))
        print("\(#function):\(answer)")
        assert(answer == 141071)
    }
    func testDay5Part1() {
        assert(PolymerUnit("a").reacts(to: PolymerUnit("a")) == false)
        assert(PolymerUnit("a").reacts(to: PolymerUnit("b")) == false)
        assert(PolymerUnit("a").reacts(to: PolymerUnit("A")) == true)
        assert(PolymerUnit("a").reacts(to: PolymerUnit("B")) == false)

        let testData1 = "dabAcCaCBAcCcaDA"
        assert(Y2018Day5.Part1(testData1) == 10)

        let answer = Y2018Day5.Part1(readInput(year: year, day: 5).first!)
        print("\(#function):\(answer)")
        assert(answer == 11814)
    }
    func testDay5Part2() {
        let testData1 = "dabAcCaCBAcCcaDA"
        assert(Y2018Day5.Part2(testData1) == 4)

        let answer = Y2018Day5.Part2(readInput(year: year, day: 5).first!)
        print("\(#function):\(answer)")
        assert(answer == 4282)
    }
    func testDay6Part1() {
        let testData1 = testDataDay6()
        assert(Y2018Day6.Part1(testData1.newlineSplit()) == 17)
        
        let answer = Y2018Day6.Part1(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 4976)
    }
    func testDay6Part2() {
        let testData1 = testDataDay6()
        assert(Y2018Day6.Part2(testData1.newlineSplit(), 32) == 16)

        let answer = Y2018Day6.Part2(readInput(year: year, day: 6), 10000)
        print("\(#function):\(answer)")
        assert(answer == 46462)
    }
    func testDay7Part1() {
        let testData1 = testDataDay7()
        assert(Y2018Day7.Part1(testData1.newlineSplit()) == "CABDFE")
        
        let answer = Y2018Day7.Part1(readInput(year: year, day: 7))
        print("\(#function):\(answer)")
        assert(answer == "FHMEQGIRSXNWZBCLOTUADJPKVY")
    }
    func testDay7Part2() {
        let testData1 = testDataDay7()
        assert(Y2018Day7.Part2(testData1.newlineSplit(), 0, 2) == 15)
        
        let answer = Y2018Day7.Part2(readInput(year: year, day: 7), 60, 5)
        print("\(#function):\(answer)")
        assert(answer == 917)
    }
    func testDay8Part1() {
        let testData1 = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
        assert(Y2018Day8.Part1(testData1) == 138)
        
        let answer = Y2018Day8.Part1(readInput(year: year, day: 8).first!)
        print("\(#function):\(answer)")
        assert(answer == 35911)
    }
    func testDay8Part2() {
        let testData1 = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
        assert(Y2018Day8.Part2(testData1) == 66)
        
        let answer = Y2018Day8.Part2(readInput(year: year, day: 8).first!)
        print("\(#function):\(answer)")
        assert(answer == 17206)
    }
    func testDay9Part1() {
        let testData1 = testDataDay9()
        assert(Y2018Day9.Part1(testData1.newlineSplit(), 1) == [32, 8317, 146373, 2764, 54718, 37305])
        
        let answer = Y2018Day9.Part1(readInput(year: year, day: 9), 1)
        print("\(#function):\(answer)")
        assert(answer == [388024])
    }
    func DISABLED_testDay9Part2() { // takes 1.4hrs
        let answer = Y2018Day9.Part1(readInput(year: year, day: 9), 100)
        print("\(#function):\(answer)")
        assert(answer == [3180929875])
    }
    func testDay10Part1() {
        let testData1 = testDataDay10()
        assert(Y2018Day10.Part1(testData1.newlineSplit(), 10).seconds == 3)
        
        let answer = Y2018Day10.Part1(readInput(year: year, day: 10), 100000)
        print("\(#function):\(answer)")
        assert(answer.seconds == 10659)
    }
    func testDay11Part1() {
        assert(Y2018Day11.Part1([18, 42], 3) == [FuelCell(33, 45, 29), FuelCell(21, 61, 30)])

        let answer = Y2018Day11.Part1([5034], 3)
        print("\(#function):\(answer)")
        assert(answer == [FuelCell(235, 63, 29)])
    }
    func DISABLED_testDay11Part2() { // takes ~40min
        assert(Y2018Day11.Part2([18, 42], 20) == [FuelCell(90, 269, 16), FuelCell(232, 251, 12)])
        
        let answer = Y2018Day11.Part2([5034], 300)
        print("\(#function):\(answer)")
        assert(answer == [FuelCell(229, 251, 16)])
    }
}

extension aoc2018Tests {
    func testDataDay2Part1() -> String {
        return """
        abcdef
        bababc
        abbcde
        abcccd
        aabcdd
        abcdee
        ababab
        """
    }
    func testDataDay2Part2() -> String {
        return """
        abcde
        fghij
        klmno
        pqrst
        fguij
        axcye
        wvxyz
        """
    }
    func testDataDay3() -> String {
        return """
        #1 @ 1,3: 4x4
        #2 @ 3,1: 4x4
        #3 @ 5,5: 2x2
        """
    }
    func testDataDay4() -> String {
        return """
        [1518-11-01 00:00] Guard #10 begins shift
        [1518-11-01 00:05] falls asleep
        [1518-11-01 00:25] wakes up
        [1518-11-01 00:30] falls asleep
        [1518-11-01 00:55] wakes up
        [1518-11-01 23:58] Guard #99 begins shift
        [1518-11-02 00:40] falls asleep
        [1518-11-02 00:50] wakes up
        [1518-11-03 00:05] Guard #10 begins shift
        [1518-11-03 00:24] falls asleep
        [1518-11-03 00:29] wakes up
        [1518-11-04 00:02] Guard #99 begins shift
        [1518-11-04 00:36] falls asleep
        [1518-11-04 00:46] wakes up
        [1518-11-05 00:03] Guard #99 begins shift
        [1518-11-05 00:45] falls asleep
        [1518-11-05 00:55] wakes up
        """
    }
    func testDataDay6() -> String {
        return """
        1, 1
        1, 6
        8, 3
        3, 4
        5, 5
        8, 9
        """
    }
    func testDataDay7() -> String {
        return """
        Step C must be finished before step A can begin.
        Step C must be finished before step F can begin.
        Step A must be finished before step B can begin.
        Step A must be finished before step D can begin.
        Step B must be finished before step E can begin.
        Step D must be finished before step E can begin.
        Step F must be finished before step E can begin.
        """
    }
    func testDataDay9() -> String {
        return """
        9 players; last marble is worth 25 points
        10 players; last marble is worth 1618 points
        13 players; last marble is worth 7999 points
        17 players; last marble is worth 1104 points
        21 players; last marble is worth 6111 points
        30 players; last marble is worth 5807 points
        """
    }
    func testDataDay10() -> String {
        return """
        position=< 9,  1> velocity=< 0,  2>
        position=< 7,  0> velocity=<-1,  0>
        position=< 3, -2> velocity=<-1,  1>
        position=< 6, 10> velocity=<-2, -1>
        position=< 2, -4> velocity=< 2,  2>
        position=<-6, 10> velocity=< 2, -2>
        position=< 1,  8> velocity=< 1, -1>
        position=< 1,  7> velocity=< 1,  0>
        position=<-3, 11> velocity=< 1, -2>
        position=< 7,  6> velocity=<-1, -1>
        position=<-2,  3> velocity=< 1,  0>
        position=<-4,  3> velocity=< 2,  0>
        position=<10, -3> velocity=<-1,  1>
        position=< 5, 11> velocity=< 1, -2>
        position=< 4,  7> velocity=< 0, -1>
        position=< 8, -2> velocity=< 0,  1>
        position=<15,  0> velocity=<-2,  0>
        position=< 1,  6> velocity=< 1,  0>
        position=< 8,  9> velocity=< 0, -1>
        position=< 3,  3> velocity=<-1,  1>
        position=< 0,  5> velocity=< 0, -1>
        position=<-2,  2> velocity=< 2,  0>
        position=< 5, -2> velocity=< 1,  2>
        position=< 1,  4> velocity=< 2,  1>
        position=<-2,  7> velocity=< 2, -2>
        position=< 3,  6> velocity=<-1, -1>
        position=< 5,  0> velocity=< 1,  0>
        position=<-6,  0> velocity=< 2,  0>
        position=< 5,  9> velocity=< 1, -2>
        position=<14,  7> velocity=<-2,  0>
        position=<-3,  6> velocity=< 2, -1>
        """
    }
}

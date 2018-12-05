//
//  aocTests.swift
//  aocTests
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import XCTest
@testable import aoc

class aocTests: XCTestCase {
    func testDay1Part1() {
        let testData1 = "+1, -2, +3, +1".commaSplit()
        let testData2 = "+1, +1, +1".commaSplit()
        let testData3 = "+1, +1, -2".commaSplit()
        let testData4 = "-1, -2, -3".commaSplit()
        assert(Day1.Part1(testData1) == 3)
        assert(Day1.Part1(testData2) == 3)
        assert(Day1.Part1(testData3) == 0)
        assert(Day1.Part1(testData4) == -6)
        
        let answer = Day1.Part1(readInput(day: 1))
        print("\(#function):\(answer)")
    }
    func testDay1Part2() {
        let testData1 = "+1, -2, +3, +1".commaSplit()
        let testData2 = "+1, -1".commaSplit()
        let testData3 = "+3, +3, +4, -2, -4".commaSplit()
        let testData4 = "-6, +3, +8, +5, -6".commaSplit()
        let testData5 = "+7, +7, -2, -7, -4".commaSplit()
        assert(Day1.Part2(testData1) == 2)
        assert(Day1.Part2(testData2) == 0)
        assert(Day1.Part2(testData3) == 10)
        assert(Day1.Part2(testData4) == 5)
        assert(Day1.Part2(testData5) == 14)
        
        let answer = Day1.Part2(readInput(day: 1))
        print("\(#function):\(answer)")
    }
    func testDay2Part1() {
        let testData1 = testDataDay2Part1()
        assert(Day2.Part1(testData1.newlineSplit()) == 12)
        
        let answer = Day2.Part1(readInput(day: 2))
        print("\(#function):\(answer)")
    }
    func testDay2Part2() {
        let testData1 = testDataDay2Part2()
        assert(Day2.Part2(testData1.newlineSplit()) == "fgij")
        
        let answer = Day2.Part2(readInput(day: 2))
        print("\(#function):\(answer)")
    }
    func testDay3Part1() {
        let testData1 = testDataDay3()
        assert(Day3.Part1(testData1.newlineSplit()) == 4)

        let answer = Day3.Part1(readInput(day: 3))
        print("\(#function):\(answer)")
    }
    func testDay3Part2() {
        let testData1 = testDataDay3()
        assert(Day3.Part2(testData1.newlineSplit()) == 3)
        
        let answer = Day3.Part2(readInput(day: 3))
        print("\(#function):\(answer)")
    }
    func testDay4Part1() {
        let testData1 = testDataDay4()
        assert(Day4.Part1(testData1.newlineSplit()) == 240)

        let answer = Day4.Part1(readInput(day: 4))
        print("\(#function):\(answer)")
    }
    func testDay4Part2() {
        let testData1 = testDataDay4()
        assert(Day4.Part2(testData1.newlineSplit()) == 4455)

        let answer = Day4.Part2(readInput(day: 4))
        print("\(#function):\(answer)")
    }
}

extension aocTests {
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
}

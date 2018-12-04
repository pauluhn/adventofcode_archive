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
}

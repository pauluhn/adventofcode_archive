//
//  aoc2019Tests.swift
//  aocTests
//
//  Created by Paul Uhn on 12/1/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2019Tests: XCTestCase {
    private var year = 2019

    func testDay1Part1() {
        assert(Y2019Day1.Part1(["12"]) == 2)
        assert(Y2019Day1.Part1(["14"]) == 2)
        assert(Y2019Day1.Part1(["1969"]) == 654)
        assert(Y2019Day1.Part1(["100756"]) == 33583)

        let answer = Y2019Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 3390830)
    }

    func testDay1Part2() {
        assert(Y2019Day1.Part2(["14"]) == 2)
        assert(Y2019Day1.Part2(["1969"]) == 966)
        assert(Y2019Day1.Part2(["100756"]) == 50346)
        
        let answer = Y2019Day1.Part2(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
        assert(answer == 5083370)
    }
    
    func testDay2Part1() {
        assert(Y2019Day2.Part1("1,9,10,3,2,3,11,0,99,30,40,50") == [3500,9,10,70,2,3,11,0,99,30,40,50])
        assert(Y2019Day2.Part1("1,0,0,0,99") == [2,0,0,0,99])
        assert(Y2019Day2.Part1("2,3,0,3,99") == [2,3,0,6,99])
        assert(Y2019Day2.Part1("2,4,4,5,99,0") == [2,4,4,5,99,9801])
        assert(Y2019Day2.Part1("1,1,1,4,99,5,6,0,99") == [30,1,1,4,2,5,6,0,99])

        let answer = Y2019Day2.Part1(readInput(year: year, day: 2).first!, true)
        print("\(#function):\(answer)")
        assert(answer.first! == 3058646)
    }

}

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

    func testDay2Part2() {
        let answer = Y2019Day2.Part2(readInput(year: year, day: 2).first!)
        print("\(#function):\(answer)")
        assert(answer == 8976)
    }
    
    func testDay3Part1() {
        assert(Y2019Day3.Part1(["R8,U5,L5,D3","U7,R6,D4,L4"]) == 6)
        assert(Y2019Day3.Part1([
            "R75,D30,R83,U83,L12,D49,R71,U7,L72",
            "U62,R66,U55,R34,D71,R55,D58,R83"]) == 159)
        assert(Y2019Day3.Part1([
            "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
            "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]) == 135)

        let answer = Y2019Day3.Part1(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 1431)
    }

    func testDay3Part2() {
        assert(Y2019Day3.Part2(["R8,U5,L5,D3","U7,R6,D4,L4"]) == 30)
        assert(Y2019Day3.Part2([
            "R75,D30,R83,U83,L12,D49,R71,U7,L72",
            "U62,R66,U55,R34,D71,R55,D58,R83"]) == 610)
        assert(Y2019Day3.Part2([
            "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
            "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]) == 410)
        
        let answer = Y2019Day3.Part2(readInput(year: year, day: 3))
        print("\(#function):\(answer)")
        assert(answer == 48012)
    }

    func testDay4Part1() {
        let answer = Y2019Day4.Part1(124075, 580769)
        print("\(#function):\(answer)")
        assert(answer == 2150)
    }

    func testDay4Part2() {
        let answer = Y2019Day4.Part2(124075, 580769)
        print("\(#function):\(answer)")
        assert(answer == 1462)
    }
    
    func testDay5Part1() {
        let answer = Y2019Day5.Part1(readInput(year: year, day: 5).first!)
        print("\(#function):\(answer)")
        assert(answer == 5182797)
    }

    func testDay5Part2() {
        assert(Y2019Day5.Part2("3,9,8,9,10,9,4,9,99,-1,8", 8) == 1)
        assert(Y2019Day5.Part2("3,9,8,9,10,9,4,9,99,-1,8", 9) == 0)

        assert(Y2019Day5.Part2("3,9,7,9,10,9,4,9,99,-1,8", 7) == 1)
        assert(Y2019Day5.Part2("3,9,7,9,10,9,4,9,99,-1,8", 8) == 0)
        
        assert(Y2019Day5.Part2("3,3,1108,-1,8,3,4,3,99", 8) == 1)
        assert(Y2019Day5.Part2("3,3,1108,-1,8,3,4,3,99", 9) == 0)
        
        assert(Y2019Day5.Part2("3,3,1107,-1,8,3,4,3,99", 7) == 1)
        assert(Y2019Day5.Part2("3,3,1107,-1,8,3,4,3,99", 8) == 0)
        
        let testData1 = testDataDay5a().newlineSplit().first!
        assert(Y2019Day5.Part2(testData1, 0) == 0)
        assert(Y2019Day5.Part2(testData1, 1) == 1)
        
        let testData2 = testDataDay5b().newlineSplit().first!
        assert(Y2019Day5.Part2(testData2, 0) == 0)
        assert(Y2019Day5.Part2(testData2, 1) == 1)

//        let testData3 = testDataDay5c().newlineSplit().first!
//        assert(Y2019Day5.Part2(testData3, 7) == 999)
//        assert(Y2019Day5.Part2(testData3, 8) == 1000)
//        assert(Y2019Day5.Part2(testData3, 9) == 1001)

        let answer = Y2019Day5.Part2(readInput(year: year, day: 5).first!, 5)
        print("\(#function):\(answer)")
        assert(answer == 12077198)
    }

    func testDay6Part1() {
        let testData1 = testDataDay6().newlineSplit()
        assert(Y2019Day6.Part1(testData1) == 42)

        let answer = Y2019Day6.Part1(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 315757)
    }
}

extension aoc2019Tests {
    func testDataDay5a() -> String {
        return "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9"
    }
    func testDataDay5b() -> String {
        return "3,3,1105,-1,9,1101,0,0,12,4,12,99,1"
    }
    func testDataDay5c() -> String {
        return "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"
    }
    func testDataDay6() -> String {
        return """
        COM)B
        B)C
        C)D
        D)E
        E)F
        B)G
        G)H
        D)I
        E)J
        J)K
        K)L
        """
    }
}

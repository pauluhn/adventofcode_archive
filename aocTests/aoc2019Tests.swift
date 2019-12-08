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
        let testData1 = testDataDay6a().newlineSplit()
        assert(Y2019Day6.Part1(testData1) == 42)

        let answer = Y2019Day6.Part1(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 315757)
    }

    func testDay6Part2() {
        let testData1 = testDataDay6b().newlineSplit()
        assert(Y2019Day6.Part2(testData1) == 4)
        
        let answer = Y2019Day6.Part2(readInput(year: year, day: 6))
        print("\(#function):\(answer)")
        assert(answer == 481)
    }
    
    func testDay7Part1() {
        let testData1 = testDataDay7a().newlineSplit().first!
        assert(Y2019Day7.Part1(testData1) == 43210)
        
        let testData2 = testDataDay7b().newlineSplit().first!
        assert(Y2019Day7.Part1(testData2) == 54321)

        let testData3 = testDataDay7c().newlineSplit().first!
        assert(Y2019Day7.Part1(testData3) == 65210)
        
        let answer = Y2019Day7.Part1(readInput(year: year, day: 7).first!)
        print("\(#function):\(answer)")
        assert(answer == 47064)
    }

    func testDay7Part2() {
        let testData1 = testDataDay7d().newlineSplit().first!
        assert(Y2019Day7.Part2(testData1) == 139629729)
        
        let testData2 = testDataDay7e().newlineSplit().first!
        assert(Y2019Day7.Part2(testData2) == 18216)
        
        let answer = Y2019Day7.Part2(readInput(year: year, day: 7).first!)
        print("\(#function):\(answer)")
        assert(answer == 4248984)
    }

    func testDay8Part1() {
        let answer = Y2019Day8.Part1(readInput(year: year, day: 8).first!)
        print("\(#function):\(answer)")
        assert(answer == 2975)
    }

    func testDay8Part2() {
        assert(Y2019Day8.Part2("0222112222120000", 2, 2) == "0110")
        
        let answer = Y2019Day8.Part2(readInput(year: year, day: 8).first!, 25, 6)
        print("\(#function):\(answer)")
        assert(answer == "111101001011100100101111010000100101001010010100001110011110100101001011100100001001011100100101000010000100101010010010100001111010010100100110011110")
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
    func testDataDay6a() -> String {
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
    func testDataDay6b() -> String {
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
        K)YOU
        I)SAN
        """
    }
    func testDataDay7a() -> String {
        return "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
    }
    func testDataDay7b() -> String {
        return "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0"
    }
    func testDataDay7c() -> String {
        return "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0"
    }
    func testDataDay7d() -> String {
        return "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
    }
    func testDataDay7e() -> String {
        return "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"
    }
}

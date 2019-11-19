//
//  aoc2017Tests.swift
//  aocTests
//
//  Created by Paul Uhn on 11/4/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2017Tests: XCTestCase {
    private var year = 2017

    func testDay8Part1() {
        let testData1 = testDataDay8()
        assert(Y2017Day8.Part1(testData1.newlineSplit()) == 1)
        
        let answer = Y2017Day8.Part1(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 3612)
    }
    
    func testDay8Part2() {
        let testData1 = testDataDay8()
        assert(Y2017Day8.Part2(testData1.newlineSplit()) == 10)
        
        let answer = Y2017Day8.Part2(readInput(year: year, day: 8))
        print("\(#function):\(answer)")
        assert(answer == 3818)
    }
    
    func testDay9Part1() {
        assert(Y2017Day9.Part1("{}") == 1) // score of 1.
        assert(Y2017Day9.Part1("{{{}}}") == 6) // score of 1 + 2 + 3 = 6.
        assert(Y2017Day9.Part1("{{},{}}") == 5) // score of 1 + 2 + 2 = 5.
        assert(Y2017Day9.Part1("{{{},{},{{}}}}") == 16) // score of 1 + 2 + 3 + 3 + 3 + 4 = 16.
        assert(Y2017Day9.Part1("{<a>,<a>,<a>,<a>}") == 1) // score of 1.
        assert(Y2017Day9.Part1("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9) // score of 1 + 2 + 2 + 2 + 2 = 9.
        assert(Y2017Day9.Part1("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9) // score of 1 + 2 + 2 + 2 + 2 = 9.
        assert(Y2017Day9.Part1("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3) // score of 1 + 2 = 3.
        
        let answer = Y2017Day9.Part1(readInput(year: year, day: 9).first!)
        print("\(#function):\(answer)")
        assert(answer == 12897)
    }
    
    func testDay9Part2() {
        let answer = Y2017Day9.Part2(readInput(year: year, day: 9).first!)
        print("\(#function):\(answer)")
        assert(answer == 7031)
    }

    func testDay10Part1() {
        assert(Y2017Day10.Part1(5, "3,4,1,5") == 12)
        
        let answer = Y2017Day10.Part1(256, readInput(year: year, day: 10).first!)
        print("\(#function):\(answer)")
        assert(answer == 9656)
    }

    func testDay10Part2() {
        assert(Y2017Day10.Part2(256, "") == "a2582a3a0e66e6e86e3812dcb672a272")
        assert(Y2017Day10.Part2(256, "AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd")
        assert(Y2017Day10.Part2(256, "1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d")
        assert(Y2017Day10.Part2(256, "1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e")

        let answer = Y2017Day10.Part2(256, readInput(year: year, day: 10).first!)
        print("\(#function):\(answer)")
        assert(answer == "20b7b54c92bf73cf3e5631458a715149")
    }

    func testDay11Part1() {
        assert(Y2017Day11.Part1("ne,ne,ne") == 3)
        assert(Y2017Day11.Part1("ne,ne,sw,sw") == 0)
        assert(Y2017Day11.Part1("ne,ne,s,s") == 2)
        assert(Y2017Day11.Part1("se,sw,se,sw,sw") == 3)

        let answer = Y2017Day11.Part1(readInput(year: year, day: 11).first!)
        print("\(#function):\(answer)")
        assert(answer == 824)
    }

    func testDay11Part2() {
        let answer = Y2017Day11.Part2(readInput(year: year, day: 11).first!)
        print("\(#function):\(answer)")
        assert(answer == 1548)
    }
}

extension aoc2017Tests {
    func testDataDay8() -> String {
        return """
        b inc 5 if a > 1
        a inc 1 if b < 5
        c dec -10 if a >= 1
        c inc -20 if c == 10
        """
    }
}

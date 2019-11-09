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

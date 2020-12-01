//
//  aoc2020Tests.swift
//  aocTests
//
//  Created by Paul U on 12/1/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import XCTest
@testable import aoc

class aoc2020Tests: XCTestCase {
    private var year = 2020

    func testDay1Part1() {
        let testData1 = testDataDay1().newlineSplit()
        assert(Y2020Day1.Part1(testData1) == 514579)
        
        let answer = Y2020Day1.Part1(readInput(year: year, day: 1))
        print("\(#function):\(answer)")
//        assert(answer == 47064)
    }

}

extension aoc2020Tests {
    func testDataDay1() -> String {
        return """
            1721
            979
            366
            299
            675
            1456
            """
    }
}

//
//  ReverseString.swift
//  aocTests
//
//  Created by Paul Uhn on 6/4/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class Solution {
    func reverseString(_ s: inout [Character]) {
        var start = s.startIndex
        var end = s.endIndex - 1
        let middle = s.count / 2
        while start < middle {
            let temp = s[start]
            s[start] = s[end]
            s[end] = temp
            start = s.index(after: start)
            end = s.index(before: end)
        }
    }
}

class ReverseStringTests: XCTestCase {
    func testCase1() {
        var input: [Character] = ["h","e","l","l","o"]
        let output: [Character] = ["o","l","l","e","h"]
        Solution().reverseString(&input)
        assert(input == output)
    }
    func testCase2() {
        var input: [Character] = ["H","a","n","n","a","h"]
        let output: [Character] = ["h","a","n","n","a","H"]
        Solution().reverseString(&input)
        assert(input == output)
    }
}

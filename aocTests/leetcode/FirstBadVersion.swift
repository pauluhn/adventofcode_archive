//
//  FirstBadVersion.swift
//  aoc
//
//  Created by Paul Uhn on 5/28/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import XCTest

private class VersionControl {
    let firstBadVersion: Int
    init(firstBadVersion: Int) {
        self.firstBadVersion = firstBadVersion
    }
    func isBadVersion(_ version: Int) -> Bool {
        return version >= firstBadVersion
    }
}

private class Solution : VersionControl {
    func firstBadVersion(_ n: Int) -> Int {
        guard n > 1 else { return n }
        return firstBadVersion(1, n)
    }
    private func firstBadVersion(_ start: Int, _ end: Int) -> Int {
        guard start < end else { return start }
        let middle = (start + end) / 2
        if isBadVersion(middle) { // go left
            return firstBadVersion(start, middle)
        } else { // go right
            return firstBadVersion(middle + 1, end)
        }
    }
}

class VersionControlTests: XCTestCase {
    func testCase1() {
        for n in 1...100 {
            for version in 1...n {
                let solution = Solution(firstBadVersion: version)
                let answer = solution.firstBadVersion(n)
                assert(answer == version)
            }
        }
    }
}

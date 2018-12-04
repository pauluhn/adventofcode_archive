//
//  Extensions.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

extension NSCountedSet {
    func count(of int: Int) -> [Element] {
        return filter { count(for: $0) == int }
    }
}

extension Collection {
    var isEmptyInt: Int {
        return isEmpty ? 0 : 1
    }
    func longer<T: Collection>(than other: T) -> Bool where Element == T.Element {
        return count > other.count
    }
}

extension String {
    typealias TwoThreeCount = (two: Int, three: Int)
    func twoThreeCount() -> TwoThreeCount {
        let countedSet = NSCountedSet(array: map(String.init))
        let two = countedSet.count(of: 2).isEmptyInt
        let three = countedSet.count(of: 3).isEmptyInt
        return (two: two, three: three)
    }
}

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
    func sorted() -> [Any] {
        return sorted { count(for: $0) > count(for: $1) }
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
        let countedSet = NSCountedSet(array: Array(self))
        let two = countedSet.count(of: 2).isEmptyInt
        let three = countedSet.count(of: 3).isEmptyInt
        return (two: two, three: three)
    }
    
    func match(_ result: NSTextCheckingResult, at index: Int) -> String {
        return (self as NSString).substring(with: result.range(at: index))
    }

    var int: Int {
        return Int(self) ?? 0
    }
}

extension DateFormatter {
    static var timestampType: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }
}

extension Date {
    var minute: Int {
        return DateFormatter.timestampType.string(from: self).split(separator: ":").last.map(String.init)!.int
    }
}

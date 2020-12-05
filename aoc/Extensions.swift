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

extension Collection where Element == Character {
    var string: String {
        return reduce("") { $0 + $1.str }
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
    var binaryInt: Int {
        return Int(self, radix: 2) ?? 0
    }
    var char: Character {
        return Character(self)
    }
    var ascii: [Int] {
        return self.compactMap { $0.asciiValue }.map(Int.init)
    }
    
    func commaSplit() -> [String] {
        return split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
    }

    func newlineSplit() -> [String] {
        return components(separatedBy: .newlines)
    }
}

extension Character {
    var str: String {
        return String(self)
    }
    var int: Int {
        return self.str.int
    }
    var ascii: [Int] {
        return self.str.ascii
    }
}

extension Substring {
    var str: String {
        return String(self)
    }
    var int: Int {
        return self.str.int
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

extension Int {
    var hexString: String {
        return String(format: "%02X", self)
    }
    var binaryString: String {
        return String(self, radix: 2)
    }
    func binaryString(length: Int) -> String {
        let binary = binaryString
        let padding = length - binary.count
        guard padding > 0 else { return binary }
        return String(repeating: "0", count: padding) + binary
    }
}

extension Set {
    /// Returns a new set with element removed
    func removing(_ element: Element) -> Set {
        var copy = self
        _ = copy.remove(element)
        return copy
    }
}

extension Array where Element: Equatable {
    /// Returns a new array with element removed
    func removing(_ element: Element) -> Array {
        var copy = self
        guard let index = firstIndex(of: element) else { return copy }
        copy.remove(at: index)
        return copy
    }
}

extension Array {
    mutating func prepend(_ element: Element) {
        insert(element, at: 0)
    }
}

// MARK: - global function

// https://github.com/raywenderlich/swift-algorithm-club/tree/master/GCD
func GCD(_ m: Int, _ n: Int) -> Int {
    var a = 0
    var b = max(m, n)
    var r = min(m, n)
    
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

func Factors(_ n: Int) -> [Int] {
    var n = n
    var a = [Int]()
    var f = 2 // first factor
    
    while n > 1 {
        if n % f == 0 {
            a.append(f)
            n /= f
        } else {
            f += 1
        }
    }
    return a
}

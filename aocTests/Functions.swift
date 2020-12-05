//
//  Functions.swift
//  aocTests
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

func readInput(year: Int, day: Int) -> [String] {
    return input(year, day).newlineSplit()
}
func readInput(year: Int, day: Int) -> String {
    return input(year, day)
}
private func url(_ year: Int, _ day: Int) -> URL {
    return Bundle(for: aoc2018Tests.self).url(forResource: "\(year)Day\(day)", withExtension: "txt")!
}
private func input(_ year: Int, _ day: Int) -> String {
    return try! String(contentsOf: url(year, day))
}

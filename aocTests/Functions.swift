//
//  Functions.swift
//  aocTests
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

func readInput(year: Int, day: Int) -> [String] {
    guard let url = Bundle(for: aoc2018Tests.self).url(forResource: "\(year)Day\(day)", withExtension: "txt") else { fatalError() }
    let input = try! String(contentsOf: url)
    return input.newlineSplit()
}

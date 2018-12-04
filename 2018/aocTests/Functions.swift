//
//  Functions.swift
//  aocTests
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

func readInput(day number: Int) -> [String] {
    guard let url = Bundle(for: aocTests.self).url(forResource: "Day\(number)", withExtension: "txt") else { fatalError() }
    let input = try! String(contentsOf: url)
    return input.components(separatedBy: .newlines)
}

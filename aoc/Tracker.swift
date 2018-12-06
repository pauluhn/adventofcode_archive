//
//  Tracker.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Tracker<T: Hashable> {
    private(set) var data: [T: Int] = [:]
    
    mutating func add(_ key: T, value: Int) {
        if let current = data[key] {
            data[key] = current + value
        } else {
            data[key] = value
        }
    }
    
    var maxKey: T? {
        return maxKeyValue?.0
    }
    
    var maxValue: Int? {
        return maxKeyValue?.1
    }
    
    private var maxKeyValue: (T, Int)? {
        return data.sorted { $0.value > $1.value }.first
    }
}

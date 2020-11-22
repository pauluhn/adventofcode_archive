//
//  Guard.swift
//  aoc
//
//  Created by Paul Uhn on 12/6/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Guard {
    let id: Int
    private(set) var sleepMinutes = NSCountedSet(array: [])
    
    var totalMinutes: Int {
        return sleepMinutes.map(sleepMinutes.count(for:)).reduce(0, +)
    }
    typealias MinuteFrequency = (minute: Int, frequency: Int)
    var minuteFrequency: MinuteFrequency {
        let sleepMinute = sleepMinutes
            .map { ($0, sleepMinutes.count(for: $0)) }
            .sorted { $0.1 > $1.1 }
            .first!
        return (sleepMinute.0 as! Int, sleepMinute.1)
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func add(minutes: [Int]) {
        sleepMinutes.addObjects(from: minutes)
    }
}
extension Guard: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//
//  Timestamp.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Timestamp {
    let dateTime: Date
    let guardState: GuardState
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^\\[(.+)\\] ([a-zG ]+)#?(\\d*).*$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        dateTime = DateFormatter.timestampType.date(from: data.match(match, at: 1))!
        
        switch data.match(match, at: 2).first {
        case "G"?:
            guardState = .begin(guardId: data.match(match, at: 3).int)
        case "f"?:
            guardState = .sleep
        case "w"?:
            guardState = .wakeUp
        default:
            fatalError()
        }
    }
}
extension Timestamp: Comparable {
    static func < (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.dateTime < rhs.dateTime
    }
    static func == (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.dateTime == rhs.dateTime
    }
}
extension Timestamp: CustomStringConvertible {
    var description: String {
        let date = DateFormatter.timestampType.string(from: dateTime)        
        return "[\(date)] \(guardState.description)"
    }
}
private extension GuardState {
    var description: String {
        switch self {
        case .begin(let guardId):
            return "Guard #\(guardId) begins shift"
        case .sleep:
            return "falls asleep"
        case .wakeUp:
            return "wakes up"
        }
    }
}

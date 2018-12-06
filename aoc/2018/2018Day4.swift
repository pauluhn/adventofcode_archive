//
//  2018Day4.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day4 {
    static func Part1(_ data: [String]) -> Int {
        assert(Timestamp("[1518-11-01 00:00] Guard #10 begins shift")!.description == "[1518-11-01 00:00] Guard #10 begins shift")
        assert(Timestamp("[1518-11-01 00:05] falls asleep")!.description == "[1518-11-01 00:05] falls asleep")
        assert(Timestamp("[1518-11-01 00:25] wakes up")!.description == "[1518-11-01 00:25] wakes up")
        
        let guards = allGuards(data)
        let chosenGuard = guards
            .sorted { $0.totalMinutes > $1.totalMinutes }
            .first!
        return chosenGuard.id * chosenGuard.minuteFrequency.minute
    }
    static func Part2(_ data: [String]) -> Int {
        let guards = allGuards(data)
        let chosenGuard = guards
            .sorted { $0.minuteFrequency.frequency > $1.minuteFrequency.frequency }
            .first!
        return chosenGuard.id * chosenGuard.minuteFrequency.minute
    }
}
private extension Y2018Day4 {
    static func allGuards(_ data: [String]) -> Set<Guard> {
        let timeline = data.compactMap(Timestamp.init).sorted()
        
        var guards = Set<Guard>()
        var currentGuardId = 0
        var sleepStart = Date()
        
        for timestamp in timeline {
            switch timestamp.guardState {
            case .begin(let guardId):
                currentGuardId = guardId
            case .sleep:
                sleepStart = timestamp.dateTime
            case .wakeUp:
                let theGuard = guards.filter { $0.id == currentGuardId }.first ?? Guard(id: currentGuardId)
                let minutes = (sleepStart.minute..<timestamp.dateTime.minute).map { $0 }
                theGuard.add(minutes: minutes)
                guards.update(with: theGuard)
            }
        }
        return guards
    }
}

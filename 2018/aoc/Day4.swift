//
//  Day4.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Day4 {
    static func Part1(_ data: [String]) -> Int {
        assert(Timestamp("[1518-11-01 00:00] Guard #10 begins shift")!.description == "[1518-11-01 00:00] Guard #10 begins shift")
        assert(Timestamp("[1518-11-01 00:05] falls asleep")!.description == "[1518-11-01 00:05] falls asleep")
        assert(Timestamp("[1518-11-01 00:25] wakes up")!.description == "[1518-11-01 00:25] wakes up")
        
        let timeline = data.compactMap(Timestamp.init).sorted()
        
        // most minutes
        var guardMinutesTracker = Tracker<Int>()
        var currentGuardId = 0
        var sleepStart = Date()
        for timestamp in timeline {
            switch timestamp.guardState {
            case .begin(let guardId):
                currentGuardId = guardId
            case .sleep:
                sleepStart = timestamp.dateTime
            case .wakeUp:
                let minutes = timestamp.dateTime.timeIntervalSince(sleepStart) * 60
                guardMinutesTracker.add(currentGuardId, value: Int(minutes))
            }
        }
        let chosenGuard = guardMinutesTracker.maxKey!
        
        // the minute
        var correctGuardId = false
        let countedSet = NSCountedSet(array: [])
        for timestamp in timeline {
            switch timestamp.guardState {
            case .begin(let guardId):
                correctGuardId = guardId == chosenGuard
            case .sleep where correctGuardId:
                sleepStart = timestamp.dateTime
            case .wakeUp where correctGuardId:
                let minutes = (sleepStart.minute..<timestamp.dateTime.minute).map { $0 }
                countedSet.addObjects(from: minutes)
            default:
                break
            }
        }
        let theMinute = countedSet.sorted().first as! Int
        
        return chosenGuard * theMinute
    }
    static func Part2(_ data: [String]) -> Int {
        let timeline = data.compactMap(Timestamp.init).sorted()

        var guardCountedSet: [Int: NSCountedSet] = [:]
        var currentGuardId = 0
        var sleepStart = Date()
        for timestamp in timeline {
            switch timestamp.guardState {
            case .begin(let guardId):
                currentGuardId = guardId
            case .sleep:
                sleepStart = timestamp.dateTime
            case .wakeUp:
                let minutes = (sleepStart.minute..<timestamp.dateTime.minute).map { $0 }
                if let countedSet = guardCountedSet[currentGuardId] {
                    countedSet.addObjects(from: minutes)
                    guardCountedSet[currentGuardId] = countedSet
                } else {
                    guardCountedSet[currentGuardId] = NSCountedSet(array: minutes)
                }
            }
        }
        let chosen = guardCountedSet
            .map { guardAndCountedSet -> (guardId: Int, minute: Int, count: Int) in
                let guardId = guardAndCountedSet.key
                let countedSet = guardAndCountedSet.value
                let minute = countedSet.sorted().first as! Int
                return (guardId: guardId, minute: minute, count: countedSet.count(for: minute))                
            }
            .sorted { $0.count > $1.count }
            .first!

        return chosen.guardId * chosen.minute
    }
}

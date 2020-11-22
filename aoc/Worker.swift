//
//  Worker.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Worker {
    enum State {
        case available
        case working
        case done
    }
    let baseTime: Int
    private(set) var state: State = .available
    private var task = ""
    private var secondsLeft = 0

    init(baseTime: Int) {
        self.baseTime = baseTime
    }
    
    mutating func work(on task: String) {
        guard state == .available else { fatalError("Worker must be available to work!") }
        self.task = task
        secondsLeft = baseTime + task.baseTime
        state = .working
    }
    
    mutating func tickTock() {
        switch state {
        case .available: return
        case .working: break
        case .done: fatalError("Worker must be available or working before a tick tock!")
        }
        secondsLeft -= 1
        if secondsLeft == 0 {
            state = .done
        }
    }
    
    mutating func ackWorkDone() -> String {
        guard state == .done else { fatalError("Worker must be done to ack!") }
        state = .available
        return task
    }
}

private extension String {
    var baseTime: Int {
        guard self.count == 1 else { fatalError() }
        let starting = Int(Unicode.Scalar("A").value)
        let current = Int(Unicode.Scalar(self)!.value)
        return current - starting + 1
    }
}

//
//  GuardState.swift
//  aoc
//
//  Created by Paul Uhn on 12/4/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

enum GuardState {
    case begin(guardId: Int)
    case sleep
    case wakeUp
}

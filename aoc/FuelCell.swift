//
//  FuelCell.swift
//  aoc
//
//  Created by Paul Uhn on 12/11/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct FuelCell: Equatable {
    let x: Int
    let y: Int
    let power: Int
    
    init(_ x: Int, _ y: Int, _ power: Int) {
        self.x = x
        self.y = y
        self.power = power
    }
    
    func changingPower(to power: Int) -> FuelCell {
        return FuelCell(x, y, power)
    }
}

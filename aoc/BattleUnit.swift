//
//  BattleUnit.swift
//  aoc
//
//  Created by Paul Uhn on 12/14/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class BattleUnit {
    enum UnitType {
        case good
        case bad
    }
    let id: String
    let type: UnitType
    var position: Point
    var attack: Int
    var hp: Int
    
    var isAlive: Bool { return hp > 0 }
    
    init(_ type: UnitType, _ x: Int, _ y: Int, _ hp: Int = 200) {
        id = UUID().uuidString
        self.type = type
        position = Point(x: x, y: y)
        attack = 3
        self.hp = hp
    }
    
    func copy() -> BattleUnit {
        return BattleUnit(type, position.x, position.y, hp)
    }
}

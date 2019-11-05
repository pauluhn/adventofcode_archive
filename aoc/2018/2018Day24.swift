//
//  2018Day24.swift
//  aoc
//
//  Created by Paul Uhn on 12/26/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day24 {
    static func Part0() {
        let data = "18 units each with 729 hit points (weak to fire; immune to cold, slashing) with an attack that does 8 radiation damage at initiative 10"
        let group = Group(data)!
        assert(group.count == 18)
        assert(group.unit.hitPoint == 729)
        assert(group.unit.attackDamage == 8)
        assert(group.unit.attackType == "radiation")
        assert(group.unit.initiative == 10)
        assert(group.unit.weaknesses == ["fire"])
        assert(group.unit.immunities == ["cold", "slashing"])
        assert(group.unit.description == "729 hit points (weak to fire; immune to cold, slashing) with an attack that does 8 radiation damage at initiative 10")
        assert(group.description == "18 units each with 729 hit points (weak to fire; immune to cold, slashing) with an attack that does 8 radiation damage at initiative 10")
        assert(group.effectivePower ==  144)
    }
    static func Part1(_ data: [String]) -> Int {
        return War(Army.generate(data)).units
    }
    private static func War(_ armies: [Army]) -> (units: Int, immuneWins: Bool) {
        fightLoop: while true {
            guard armies.filter({ $0.groups.count > 0 }).count > 1 else { break fightLoop }
            
            // target selection
            let allGroups = armies.flatMap { $0.groups }.sortedForTargetSelection()
            var targetMap = [Group: Group]() // attacker: target
            for group in allGroups {
                let targets = allGroups
                    .filter { $0.army != group.army }
                    .filter { !targetMap.values.contains($0) }
                if let target = group.target(from: targets) {
                    targetMap[group] = target
                }
            }
//            printTargetMap(targetMap)
            
            // attacking
            var allKilled = 0
            attackLoop: for group in allGroups.sortedForAttack() {
                guard group.count > 0 else { continue attackLoop }
                
                if let target = targetMap[group] {
                    let killed = group.attack(target: target)
                    target.count -= killed
                    allKilled += killed
//                    printAttack(group, target, killed)
                }
            }
            guard allKilled > 0 else { return (0, false) }
            
            // clean
            for (i, army) in armies.enumerated() {
                for group in army.groups where group.count == 0 {
                    armies[i].groups.removeAll { $0 == group }
                }
            }
        }
        
        let units = armies.reduce(0) { $0 + $1.groups.reduce(0) { $0 + $1.count }}
        let immuneWins = armies.filter { $0.groups.count > 0 }.first!.name == Army.immune
        return (units, immuneWins)
    }
    static func Part2(_ data: [String], _ startBoost: Int) -> (boost: Int, units: Int) {
        var boost = startBoost
        while true {
//            print(boost)
            let armies = Army.generate(data)
            let groups = armies.flatMap { $0.groups }.filter { $0.army == Army.immune }
            groups.forEach { $0.boost(boost) }
            
            let result = War(armies)
            guard !result.immuneWins else { return (boost, result.units) }
            
            boost += 1
        }
    }
    private static func printTargetMap(_ targetMap: [Group: Group]) {
        for (a, t) in targetMap {
            print("\(a.army) group \(a.id) targets \(t.army) group \(t.id) for \(a.damage(to: t)) damage")
        }
    }
    private static func printAttack(_ a: Group, _ t: Group, _ killed: Int) {
        print("\(a.army) group \(a.id) attacks defending group \(t.id), killing \(killed) units")
    }
}

// MARK: - Models
private class Army {
    let name: String
    var groups = [Group]()
    init(_ name: String) { self.name = name.trimmingCharacters(in: .custom) }
    
    static let immune = "Immune System"
    
    static func generate(_ data: [String]) -> [Army] {
        var armies = [Army]()
        for d in data where !d.isEmpty {
            if let group = Group(d) {
                group.army = armies.last!.name
                group.armyId = armies.count - 1
                group.id = armies.last!.groups.count + 1
                armies.last!.groups.append(group)
            } else {
                armies.append(Army(d))
            }
        }
        return armies
    }
}
private class Group {
    var army = ""
    var armyId = 0
    var id = 0
    private(set) var unit: Unit
    var count: Int
    var effectivePower: Int { return count * (unit.attackDamage + unit.boost) }
    
    init?(_ data: String) {
        let regex = try! NSRegularExpression(pattern: "^(\\d+) units each with (\\d+) hit points([\\s\\(a-z,;\\)]+)with an attack that does (\\d+) ([a-z]+) damage at initiative (\\d+)$")
        guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
        
        count = data.match(match, at: 1).int
        let hitPoint = data.match(match, at: 2).int
        let weaknessImmunityList = Group.parse(data.match(match, at: 3))
        let attackDamage = data.match(match, at: 4).int
        let attackType = data.match(match, at: 5)
        let initiative = data.match(match, at: 6).int
        unit = Unit(
            hitPoint: hitPoint,
            attackDamage: attackDamage,
            attackType: attackType,
            initiative: initiative,
            weaknesses: weaknessImmunityList.weaknesses,
            immunities: weaknessImmunityList.immunities,
            weaknessFirst: weaknessImmunityList.weaknessFirst,
            boost: 0
        )
    }
    
    private static func parse(_ data: String) -> (weaknesses: [String], immunities: [String], weaknessFirst: Bool) {
        let data = data.trimmingCharacters(in: .custom)
        guard !data.isEmpty else { return ([], [], false) }
        let list: ([String], [String]) = data
            .split(separator: ";")
            .map { parse($0) }
            .reduce(([], [])) { (result, tuple) in
                var result = result
                if tuple.isWeakness {
                    result.0 = tuple.list
                } else {
                    result.1 = tuple.list
                }
                return result
            }
        return (list.0, list.1, data.first == "w")
    }
    private static func parse(_ data: Substring) -> (isWeakness: Bool, list: [String]) {
        var data = data.trimmingCharacters(in: .whitespacesAndNewlines)
        let weak = "weak to "
        let immune = "immune to "
        
        var isWeakness = false
        switch data.first {
        case "w"?:
            isWeakness = true
            data.removeFirst(weak.count)
        case "i"?:
            data.removeFirst(immune.count)
        default:
            return (false, [])
        }
        let list = data.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        return (isWeakness, list)
    }
    
    func damage(to target: Group) -> Int {
        if target.unit.immunities.contains(unit.attackType) {
            return 0
        } else if target.unit.weaknesses.contains(unit.attackType) {
            return effectivePower * 2
        } else {
            return effectivePower
        }
    }
    
    func target(from list: [Group]) -> Group? {
        guard !list.isEmpty else { return nil }
        
        let sortedTargets: [(Group, Int)] = list.compactMap {
            let damage = self.damage(to: $0)
            if damage == 0 { return nil }
            return ($0, damage)
        }
        .sorted { $0.1 > $1.1 }
        guard !sortedTargets.isEmpty else { return nil }

        let damage = sortedTargets.first!.1
        let targets = sortedTargets
            .filter { $0.1 == damage }
            .map { $0.0 }
        guard targets.count > 1 else { return targets.first }
        
        return targets.sortedForTargetSelection().first
    }
    
    func attack(target: Group) -> Int { // killed
        let units = target.count
        let hp = target.unit.hitPoint
        let remaining = units * hp - damage(to: target)
        guard remaining > 0 else { return units }
        let partial = remaining % hp != 0 ? 1 : 0
        let survived = remaining / hp + partial
        return units - survived
    }
    
    func boost(_ boost: Int) {
        unit.boost = boost
    }
}
private struct Unit {
    let hitPoint: Int
    let attackDamage: Int
    let attackType: String
    let initiative: Int
    let weaknesses: [String]
    let immunities: [String]
    let weaknessFirst: Bool
    var boost: Int
}
// MARK: - CustomStringConvertible
extension Group: CustomStringConvertible {
    var description: String {
        return "\(count) units each with \(unit)"
    }
}
extension Unit: CustomStringConvertible {
    var description: String {
        return "\(hitPoint) hit points \(weaknessImmunityList)with an attack that does \(attackDamage + boost) \(attackType) damage at initiative \(initiative)"
    }
    private var weaknessImmunityList: String {
        let list = orderedList.compactMap { $0 }.joined(separator: "; ")
        return "(\(list)) "
    }
    private var orderedList: [String?] {
        let list = [weaknessList, immunityList]
        return weaknessFirst ? list : list.reversed()
    }
    private var weaknessList: String? {
        guard !weaknesses.isEmpty else { return nil }
        return "weak to \(list(weaknesses))"
    }
    private var immunityList: String? {
        guard !immunities.isEmpty else { return nil }
        return "immune to \(list(immunities))"
    }
    private func list(_ data: [String]) -> String {
        return data.joined(separator: ", ")
    }
}

// MARK: - Hashable
extension Group: Hashable {
    var hashValue: Int {
        return army.hashValue ^ unit.hashValue
    }
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.army == rhs.army && lhs.unit == rhs.unit
    }
}
extension Unit: Hashable {}

// MARK: - Extensions
private extension CharacterSet {
    static var custom: CharacterSet {
        var set = CharacterSet.whitespacesAndNewlines
        set.insert(charactersIn: "(:)")
        return set
    }
}
private extension Sequence where Element == Group {
    func sortedForTargetSelection() -> [Element] {
        return sorted {
            if $0.effectivePower == $1.effectivePower {
                return $0.unit.initiative > $1.unit.initiative
            }
            return $0.effectivePower > $1.effectivePower
        }
    }
    func sortedForAttack() -> [Element] {
        return sorted { $0.unit.initiative > $1.unit.initiative }
    }
}

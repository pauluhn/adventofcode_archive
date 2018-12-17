//
//  2018Day15.swift
//  aoc
//
//  Created by Paul Uhn on 12/14/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day15 {
    static func Part0() {
        let testData = ["#######",
                        "#E..G.#",
                        "#...#.#",
                        "#.G.#G#",
                        "#######"]
        let testField = testData.map { $0.map { $0 }}
        let testInRange = [Point(x: 3, y: 1),
                           Point(x: 5, y: 1),
                           Point(x: 2, y: 2),
                           Point(x: 5, y: 2),
                           Point(x: 1, y: 3),
                           Point(x: 3, y: 3)]
        let testPathFind = testInRange.map { pathFinder(Point(x: 1, y: 1), $0, testField, 10) }
        let testCount = testPathFind.map { $0.count }
        assert(testCount == [2, 0, 2, 0, 2, 4])
        
        let testData2 = ["#######",
                         "#.E...#",
                         "#.....#",
                         "#...G.#",
                         "#######"]
        let testField2 = testData2.map { $0.map { $0 }}
        let start = Point(x: 2, y: 1)
        let chosen = Point(x: 4, y: 2)
        let testPathFind2 = pathFinder(start, chosen, testField2, 10)
        assert(testPathFind2.first == Point(x: 3, y: 1))
        
        let testData3 = ["#########",
                         "#G..G..G#",
                         "#.......#",
                         "#.......#",
                         "#G..E..G#",
                         "#.......#",
                         "#.......#",
                         "#G..G..G#",
                         "#########"]
        assert(Part1(testData3, true, false, 3) == 3 * 9 * 200)
        
        let testData4 = ["#######",
                         "#G....#",
                         "#..G..#",
                         "#..EG.#",
                         "#..G..#",
                         "#...G.#",
                         "#######"]
        let testUnits4 = [BattleUnit(.bad, 1, 1, 9),
                          BattleUnit(.bad, 3, 2, 4),
                          BattleUnit(.good, 3, 3),
                          BattleUnit(.bad, 4, 3, 2),
                          BattleUnit(.bad, 3, 4, 2),
                          BattleUnit(.bad, 4, 5, 1)]
        assert(Part1(testData4, false, true, 1, testUnits4) == 1 * (9 + 4 + (200 - 3 * 2) + 2 + 1))
    }
    static func Part1(_ data: [String], _ allowedToMove: Bool = true, _ battleMode: Bool = true, _ rounds: Int = -1, _ loadUnits: [BattleUnit]? = nil) -> Int {
        var battlefield = data.map { $0.map { $0 }}
        var units = loadUnits ?? getUnits(battlefield)
        remove(units, from: &battlefield)
        
        var round = 0
        gameLoop: while continueGame(round, rounds) { // or no more targets
            unitLoop: for (i, unit) in units.sorted(by: Sort.unit).enumerated() {
                // check life
                guard let _ = units.first(where: { $0.id == unit.id }) else {
                    print("round \(round), unit \(i) is dead")
                    continue unitLoop } // skip dead unit
                
                let targets = getTargets(unit, units)
                if targets.isEmpty { break gameLoop } // end game

                var mapWithUnits = battlefield
                put(units, on: &mapWithUnits)

                let inRange = getInRange(unit, targets, mapWithUnits)
                if inRange.isEmpty {
                    print("round \(round), unit \(i) with \(unit.hp) hp - no moves")
                    continue unitLoop } // end turn
                
                var moved = false
                if !inRange.contains(unit.position) && allowedToMove {
                    // move
                    let reachable = inRange
                        .map { pathFinder(unit.position, $0, mapWithUnits, battlefield.count * 2) } // adjust threshold???
                        .filter { !$0.isEmpty }
                    //
                    let sorted = reachable.sorted { $0.count < $1.count }
                    let count = sorted.first?.count
                    let nearest = sorted.filter { $0.count == count }
                    //
                    if let chosen = nearest.sorted(by: Sort.points(false)).first?.first {
                        moved = true
                        unit.position = chosen
                    }
                }
                if battleMode {
                    // attack
                    let inRangeTargets = getInRangeTargets(unit, targets)
                    if inRangeTargets.isEmpty {
                        print("round \(round), unit \(i) with \(unit.hp) hp - no attack \(moved ? "" : "- did not move")")
                        continue unitLoop } // end turn
                    let target = getBestTarget(inRangeTargets)
                    target.hp -= unit.attack
                    if !target.isAlive {
                        // dies
                        units.removeAll { $0.id == target.id }
                    }
                }
                print("round \(round), unit \(i) with \(unit.hp) hp \(moved ? "" : "- did not move")")
                // print
//                mapWithUnits = battlefield
//                put(units, on: &mapWithUnits)
//                printBattlefield(mapWithUnits)
            }
            round += 1
            // print
            var mapWithUnits = battlefield
            put(units, on: &mapWithUnits)
            print(round)
            printBattlefield(mapWithUnits)
        }
        return round * units.map { $0.hp }.reduce(0, +)
    }
}
private extension Y2018Day15 {
    static func getUnits(_ battlefield: [[Character]]) -> [BattleUnit] {
        var units = [BattleUnit]()
        for (y, array) in battlefield.enumerated() {
            for (x, char) in array.enumerated() where char.isBattleUnit {
                units.append(BattleUnit(char.isElf ? .good : .bad, x, y))
            }
        }
        return units
    }
    static func remove(_ units: [BattleUnit], from battlefield: inout [[Character]]) {
        for unit in units {
            battlefield[unit.position.y][unit.position.x] = Character.openCavern
        }
    }
    static func put(_ units: [BattleUnit], on battlefield: inout [[Character]]) {
        for unit in units {
            battlefield[unit.position.y][unit.position.x] = unit.type == .good ? .elf : .goblin
        }
    }
    static func getTargets(_ unit: BattleUnit, _ units: [BattleUnit]) -> [BattleUnit] {
        return units.filter { $0.type != unit.type }
    }
    static func getInRange(_ unit: BattleUnit, _ targets: [BattleUnit], _ battlefield: [[Character]]) -> [Point] {
        return targets.flatMap { $0.position.adjacent }.filter { $0 == unit.position || battlefield[$0.y][$0.x] == .openCavern }
    }
    static func getInRangeTargets(_ unit: BattleUnit,  _ targets: [BattleUnit]) -> [BattleUnit] {
        let inRange = unit.position.adjacent
        return targets.filter { inRange.contains($0.position) }
    }
    static func getBestTarget(_ inRangeTargets: [BattleUnit]) -> BattleUnit {
        let sorted = inRangeTargets.filter { $0.isAlive }.sorted { $0.hp < $1.hp }
        let lowest = sorted.first?.hp
        let targets = sorted.filter { $0.hp == lowest }
        return targets.sorted(by: Sort.unit).first!
    }
    static func pathFinder(_ start: Point, _ end: Point, _ mapWithUnits: [[Character]], _ threshold: Int) -> [Point] {
        let queue = Queue<(Point, [Point])>() // (point, path)
        let points = start.adjacent
            .map { ($0, [$0]) }
            .filter { Filter.openPoint(mapWithUnits)($0.0) }
        queue.push(points)
        
        var paths = [[Point]]()
        
        while !queue.isEmpty && queue.count < 100 * threshold {
            let (point, path) = queue.pop()!
            if point == start { break } // unreachable
            if path.count > threshold { break } // unreachable
            if point == end {
                paths.append(path)
                if path.count > paths.first!.count {
                    paths.removeLast()
                    break // all nearest found
                } else {
                    continue
                }
            }
            let points = point.adjacent
                .filter { !path.contains($0) }
                .map { ($0, path + [$0]) }
                .filter { Filter.openPoint(mapWithUnits)($0.0) }
            queue.push(points)
        }
        let chosen = paths.sorted(by: Sort.points(true)).first ?? []
        return chosen
    }
    static func continueGame(_ round: Int, _ rounds: Int) -> Bool {
        if rounds == -1 {
            return true
        }
        return round < rounds
    }
    static func printBattlefield(_ mapWithUnits: [[Character]]) {
        let display = mapWithUnits.reduce("") { $0 + $1.reduce("") { $0 + String($1) } + "\n" }
        print(display)
    }
}
private extension Character {
    static let wall: Character = "#"
    static let openCavern: Character = "."
    static let elf: Character = "E"
    static let goblin: Character = "G"
    
    var isBattleUnit: Bool {
        switch self {
        case .elf, .goblin: return true
        default: return false
        }
    }
    var isElf: Bool {
        switch self {
        case .elf: return true
        default: return false
        }
    }
    var isGoblin: Bool {
        switch self {
        case .goblin: return true
        default: return false
        }
    }
}
private extension Point {
    var adjacent: [Point] {
        return [
            Point(x: x + 1, y: y),
            Point(x: x - 1, y: y),
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1)
        ]
    }
    func manDis(_ end: Point) -> Int {
        return manhattanDistance(from: end)
    }
}
private struct Sort {
    static let point: (Point, Point) -> Bool = { (p1, p2) in
        if p1.y == p2.y {
            return p1.x < p2.x
        }
        return p1.y < p2.y
    }
    static func points(_ checkFirst: Bool) -> ([Point], [Point]) -> Bool {
        return { (points1, points2) in
            let p1 = checkFirst ? points1.first : points1.last
            let p2 = checkFirst ? points2.first : points2.last
            switch (p1, p2) {
            case (nil, nil): return true
            case (nil, .some): return false
            case (.some, nil): return true
            default: break
            }
            let f1 = p1!
            let f2 = p2!
            if f1.y == f2.y {
                return f1.x < f2.x
            }
            return f1.y < f2.y
        }
    }
    static let unit: (BattleUnit, BattleUnit) -> Bool = { (unit1, unit2) in
        if unit1.position.y == unit2.position.y {
            return unit1.position.x < unit2.position.x
        }
        return unit1.position.y < unit2.position.y
    }
    static func point(manDis end: Point) -> (Point, Point) -> Bool {
        return { (p1, p2) in
            return p1.manDis(end) < p2.manDis(end)
        }
    }
}
private struct Filter {
    static func openPoint(_ mapWithUnits: [[Character]]) -> (Point) -> Bool {
        return { mapWithUnits[$0.y][$0.x] == .openCavern }
    }
}

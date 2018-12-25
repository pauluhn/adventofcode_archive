//
//  2018Day15.swift
//  aoc
//
//  Created by Paul Uhn on 12/14/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day15 {
    typealias Node = Graph<Point>.GraphNode<Point>
    fileprivate enum Value {
        case wall
        case open
        case elf
        case goblin
    }
    static func Part0() {
        var graph = Graph<Point>()
        var units = [BattleUnit]()
        // reading order of positions
        let testData0 = ["#######",
                         "#.G.E.#",
                         "#E.G.E#",
                         "#.G.E.#",
                         "#######"]
        (graph, units) = Graph.generateMap(testData0)
        let positions = units
            .shuffled()
            .sortedByReadingOrder()
            .map { $0.position }
        assert(positions == [Point(x: 2, y: 1),
                             Point(x: 4, y: 1),
                             Point(x: 1, y: 2),
                             Point(x: 3, y: 2),
                             Point(x: 5, y: 2),
                             Point(x: 2, y: 3),
                             Point(x: 4, y: 3)])
        // move
        let testData1 = ["#######",
                         "#E..G.#",
                         "#...#.#",
                         "#.G.#G#",
                         "#######"]
        (graph, units) = Graph.generateMap(testData1)
        // 1. targets
        var elf = units.first { $0.isElf }!
        let targets = elf.targets(units)
        assert(targets.map({ $0.position }) == [Point(x: 4, y: 1),
                                                Point(x: 2, y: 3),
                                                Point(x: 5, y: 3)])
        // 2. in range
        let targetNodes = targets.compactMap { t in
            graph.nodes.first { $0.value == t.position }
        }
        let inRange = targetNodes
            .flatMap { graph.adjacent($0) }
            .shuffled()
            .sortedByReadingOrder()
        assert(inRange.map({ $0.value }) == [Point(x: 3, y: 1),
                                             Point(x: 5, y: 1),
                                             Point(x: 2, y: 2),
                                             Point(x: 5, y: 2),
                                             Point(x: 1, y: 3),
                                             Point(x: 3, y: 3)])
        // 3. reachable
        var elfNode = graph.nodes.first { $0.value == elf.position }!
        let reachable = inRange
            .filter { graph.reachable(elfNode, to: $0, all: units) }
        assert(reachable.map({ $0.value }) == [Point(x: 3, y: 1),
                                               Point(x: 2, y: 2),
                                               Point(x: 1, y: 3),
                                               Point(x: 3, y: 3)])
        // 4. nearest
        let nearestTuples = inRange
            .map { ($0, graph.nearest(elfNode, to: $0, all: units)) }
            .filter { $0.1 != nil }
            .map { ($0.0, $0.1!) }
            .sorted { $0.1 < $1.1 }
        let nearestInt = nearestTuples.first!.1
        let nearest = nearestTuples
            .filter { $0.1 == nearestInt }
            .map { $0.0 }
        assert(nearest.map({ $0.value }) == [Point(x: 3, y: 1),
                                             Point(x: 2, y: 2),
                                             Point(x: 1, y: 3)])
        // 5. chosen
        var chosen = nearest
            .shuffled()
            .sortedByReadingOrder().first!
        assert(chosen.value == Point(x: 3, y: 1))
        // step
        let testData2 = ["#######",
                         "#.E...#",
                         "#.....#",
                         "#...G.#",
                         "#######"]
        (graph, units) = Graph.generateMap(testData2)
        elf = units.first { $0.isElf }!
        chosen = graph.move(elf, all: units)
        // 1. distance
        elfNode = graph.nodes.first { $0.value == elf.position }!
        let steps = graph.adjacent(elfNode)
        let distanceTuples = steps
            .map { ($0, graph.nearest($0, to: chosen, all: units)) }
            .filter { $0.1 != nil }
            .map { ($0.0, $0.1!) }
            .sorted { $0.1 < $1.1 }
        let distanceInt = distanceTuples.first!.1
        let distances = distanceTuples
            .filter { $0.1 == distanceInt }
            .map { $0.0 }
            .sortedByReadingOrder()
        assert(distances.map({ $0.value }) == [Point(x: 3, y: 1),
                                               Point(x: 2, y: 2)])
        // 2. step
        assert(distances.first!.value == Point(x: 3, y: 1))
        
        // no move
        let testData22 = ["####",
                          "#EG#",
                          "####"]
        (graph, units) = Graph.generateMap(testData22)
        elf = units.first { $0.isElf }!
        chosen = graph.move(elf, all: units)
        assert(chosen.value == elf.position)
        let step = graph.step(elf, all: units, chosen: chosen)
        assert(step.value == elf.position)

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
        let (graph, u) = Graph.generateMap(data)
        var units = loadUnits ?? u
        
        var round = 0
        gameLoop: while continueGame(round, rounds) {
            unitLoop: for (i, unit) in units.sortedByReadingOrder().enumerated() {
                guard let _ = units.first(where: { $0.id == unit.id }) else {
                    continue unitLoop  // skip dead unit
                }
                
                guard !unit.targets(units).isEmpty else {
                    break gameLoop // end game
                }

                if allowedToMove {
                    let chosen = graph.move(unit, all: units)
                    let step = graph.step(unit, all: units, chosen: chosen)
                    unit.position = step.value
                }
                
                if battleMode {
                    if let target = graph.aim(unit, all: units) {
                        target.hp -= unit.attack
                        if !target.isAlive {
                            units.removeAll { $0.id == target.id }
                        }
                    }
                }
                // print
//                print("\(round).\(i)")
//                graph.printMap(units)
            }
            round += 1
            // print
//            print(round)
//            graph.printMap(units)
        }
        return round * units.map { $0.hp }.reduce(0, +)
    }
    static func Part2(_ data: [String]) -> (Int, Int) {
        let (graph, u) = Graph.generateMap(data)
        let elvesCount = u.filter { $0.isElf }.count
        
        var units = u.copy()
        var power = units.first?.attack ?? 3
        var score = 0
        partLoop: while true {
            var round = 0
            gameLoop: while true {
                unitLoop: for unit in units.sortedByReadingOrder() {
                    // check life
                    guard let _ = units.first(where: { $0.id == unit.id }) else {
                        continue unitLoop  // skip dead unit
                    }
                    
                    guard !unit.targets(units).isEmpty else {
                        break gameLoop // end game
                    }
                    
                    let chosen = graph.move(unit, all: units)
                    let step = graph.step(unit, all: units, chosen: chosen)
                    unit.position = step.value
                    
                    if let target = graph.aim(unit, all: units) {
                        target.hp -= unit.attack
                        if !target.isAlive {
                            guard target.isGoblin else { break gameLoop } // elf died
                            units.removeAll { $0.id == target.id }
                        }
                    }
                }
                round += 1
            }
            score = round * units.map { $0.hp }.reduce(0, +)
            let elvesWin = units.count == elvesCount && units.first!.isElf
            guard !elvesWin else { break partLoop }
            power += 1
            print("bumping power to \(power)")
            units = u.copy()
            for unit in units where unit.isElf {
                unit.attack = power
            }
        }
        return (power, score)
    }
}
private extension Y2018Day15 {
    static func continueGame(_ round: Int, _ rounds: Int) -> Bool {
        if rounds == -1 {
            return true
        }
        return round < rounds
    }
}
private extension Graph where T == Point {
    static func generateMap(_ data: [String]) -> (map: Graph, units: [BattleUnit]) {
        let graph = Graph<Point>()
        var units = [BattleUnit]()
        for (y, array) in data.enumerated() {
            loop: for (x, d) in array.enumerated() {
                switch d.value {
                case .wall: continue loop
                case .open: break
                case .elf: units.append(BattleUnit(.good, x, y))
                case .goblin: units.append(BattleUnit(.bad, x, y))
                }
                let point = Point(x: x, y: y)
                let node = graph.create(point)
                graph.link(node)
            }
        }
        return (graph, units)
    }
    private func link(_ node: Node) {
        let directions: [Direction] = [.up, .left]
        let nodes = directions.compactMap { self.node($0, of: node) }
        nodes.forEach {
            self.link(node, to: $0)
            self.link($0, to: node)
        }
    }
    func node(_ direction: Direction, of node: Node) -> Node? {
        let offset = node.value.offset(by: direction.offset)
        return nodes.first { $0.value == offset }
    }
    func adjacent(_ node: Node) -> [Node] {
        let directions: [Direction] = [.up, .down, .left, .right]
        return directions.compactMap { self.node($0, of: node) }
    }
    func reachable(_ from: Node, to: Node, all: [BattleUnit]) -> Bool {
        return nearest(from, to: to, all: all) != nil
    }
    func nearest(_ from: Node, to: Node, all: [BattleUnit]) -> Int? {
        guard from != to else { return 1 }
        var memo = [Node: Int]()
        var block = all.map { $0.position }
        block.removeAll { $0 == to.value }
        
        let queue = Queue<Node>()
        queue.push(from)
        memo[from] = 1
        
        while true {
            guard let node = queue.pop(),
                let weight = memo[node] else { break }
            let items = links(node)
            for item in items {
                if item.to == to {
                    return weight // found
                }
                if block.contains(item.to.value) {
                    continue
                }
                block.append(item.to.value)

                queue.push(item.to)
                memo[item.to] = weight + 1
            }
        }
        return nil
    }
    func move(_ unit: BattleUnit, all units: [BattleUnit]) -> Node {
        let unitNode = nodes.first { $0.value == unit.position }!
        let targets = unit.targets(units)
        let targetNodes = targets.compactMap { t in
            self.nodes.first { $0.value == t.position }
        }
        let block = units
            .map { $0.position }
            .filter { $0 != unit.position }
        let inRange = targetNodes
            .flatMap { self.adjacent($0) }
            .filter { !block.contains($0.value) }
            .sortedByReadingOrder()
        guard !inRange.map({ $0.value }).contains(unit.position) else { return unitNode }
        let nearestTuples = inRange
            .map { ($0, self.nearest(unitNode, to: $0, all: units)) }
            .filter { $0.1 != nil }
            .map { ($0.0, $0.1!) }
            .sorted { $0.1 < $1.1 }
        guard !nearestTuples.isEmpty else { return unitNode }
        let nearestInt = nearestTuples.first!.1
        let nearest = nearestTuples
            .filter { $0.1 == nearestInt }
            .map { $0.0 }
        return nearest.sortedByReadingOrder().first!
    }
    func step(_ unit: BattleUnit, all units: [BattleUnit], chosen: Node) -> Node {
        guard unit.position != chosen.value else { return chosen }
        let unitNode = nodes.first { $0.value == unit.position }!
        let block = units
            .map { $0.position }
            .filter { $0 != unit.position }
        let steps = adjacent(unitNode)
            .filter { !block.contains($0.value) }
        let distanceTuples = steps
            .map { ($0, self.nearest($0, to: chosen, all: units)) }
            .filter { $0.1 != nil }
            .map { ($0.0, $0.1!) }
            .sorted { $0.1 < $1.1 }
        let distanceInt = distanceTuples.first!.1
        let distances = distanceTuples
            .filter { $0.1 == distanceInt }
            .map { $0.0 }
        return distances.sortedByReadingOrder().first!
    }
    func aim(_ unit: BattleUnit, all units: [BattleUnit]) -> BattleUnit? {
        let unitNode = nodes.first { $0.value == unit.position }!
        let adjacentPoints = adjacent(unitNode).map { $0.value }
        let targetTuples = unit.targets(units)
            .filter { adjacentPoints.contains($0.position) }
            .filter { $0.isAlive }
            .map { ($0, $0.hp) }
            .sorted { $0.1 < $1.1 }
        guard !targetTuples.isEmpty else { return nil }
        let targetInt = targetTuples.first!.1
        let targets = targetTuples
            .filter { $0.1 == targetInt }
            .map { $0.0 }
        return targets.sortedByReadingOrder().first
    }
    func printMap(_ units: [BattleUnit]) {
        let points = nodes.map { $0.value }
        let width = points.map { $0.x }.sorted().last! + 2
        let height = points.map { $0.y }.sorted().last! + 2
        
        var map: [[Character]] = Array(repeating: Array(repeating: .wall, count: width), count: height)
        nodes.forEach {
            map[$0.value.y][$0.value.x] = .open
        }
        units.forEach {
            if $0.isAlive {
                map[$0.position.y][$0.position.x] = $0.isElf ? .elf : .goblin
            }
        }
        let display = map.reduce("") { $0 + $1.reduce("") { $0 + String($1) } + "\n" }
        let stats = units.sortedByReadingOrder().reduce("") { $0 + "(\($1.hp))" }
        print("\(display)\(stats)\n")
    }
}
private extension Character {
    static let wall: Character = "#"
    static let open: Character = "."
    static let elf: Character = "E"
    static let goblin: Character = "G"

    var value: Y2018Day15.Value {
        switch self {
        case "#": return .wall
        case ".": return .open
        case "E": return .elf
        case "G": return .goblin
        default: fatalError()
        }
    }
}
private extension Sequence where Element == BattleUnit {
    func sortedByReadingOrder() -> [Element] {
        return sorted {
            if $0.position.y == $1.position.y {
                return $0.position.x < $1.position.x
            }
            return $0.position.y < $1.position.y
        }
    }
    func copy() -> [Element] {
        return map { $0.copy() }
    }
}
private extension Sequence where Element == Y2018Day15.Node {
    func sortedByReadingOrder() -> [Element] {
        return sorted {
            if $0.value.y == $1.value.y {
                return $0.value.x < $1.value.x
            }
            return $0.value.y < $1.value.y
        }
    }
}
private extension Sequence where Element == Point {
    func sortedByReadingOrder() -> [Element] {
        return sorted {
            if $0.y == $1.y {
                return $0.x < $1.x
            }
            return $0.y < $1.y
        }
    }
}
private extension BattleUnit {
    var isElf: Bool { return type == .good }
    var isGoblin: Bool { return type == .bad }

    func targets(_ all: [BattleUnit]) -> [BattleUnit] {
        return all.filter { $0.type != type }
    }
}

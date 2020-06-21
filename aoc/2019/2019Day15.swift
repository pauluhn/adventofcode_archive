//
//  2019Day15.swift
//  aoc
//
//  Created by Paul Uhn on 1/4/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day15 {
    
    enum Move: Int {
        case north = 1
        case south
        case west
        case east
    }
    
    enum Tile: Int {
        case wall = 0
        case empty
        case oxygen
        case droid
        case unexplored
    }
    
    struct Droid {
        var position = Point.zero
        var facing = Move.north
        var goal = Point(x: 0, y: -1)
    }
    
    typealias Node = Graph<Point>.GraphNode<Point>
    
    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var droid = Droid()
        var map = [droid.position: Tile.empty]
        let graph = Graph<Point>()
        var oxygen = Point.zero
        
        // initial map/graph
        let previousNode = graph.create(droid.position)
        Direction.valid
            .map { droid.position.offset(by: $0.offset) }
            .forEach {
                map[$0] = .unexplored
                link(graph, previousNode, $0)
        }
        
        var intcode: IntcodeComputer!
        intcode = IntcodeComputer(
            program: program,
            inputs: [droid.facing.rawValue],
            limitedMemory: false) {
                switch Tile(rawValue: $0) {
                case .wall?:
                    let wall = droid.offset
                    map[wall] = .wall
                    unlink(graph, droid, wall)
                    droid.goal = droid.position
                    
                case .empty?:
                    droid.position = droid.offset
                    map[droid.position] = .empty
                    
                case .oxygen?:
                    droid.position = droid.offset
                    map[droid.position] = .oxygen
                    oxygen = droid.position
                    
                case .droid?, .unexplored?, nil:
                    fatalError()
                }
                // mark unexplored
                unexplored(&map, droid, graph)

                if droid.position == droid.goal {
                    // find next unexplored
                    guard let unexplored = breadth(map, graph, droid) else {
                        // finished exploring
                        intcode.kill()
                        return
                    }
                    droid.goal = unexplored
                }
                
                let next = a_star(graph, droid.position, droid.goal)[1] // second item = next
                droid.facing = droid.position.direction(to: next).move
                intcode.appendInput(droid.facing.rawValue)
                
                // draw map
                draw(map, droid)
        }
        var tick = false
        repeat { tick = intcode.tick() } while tick
        
        return a_star(graph, .zero, oxygen).count - 1
    }

    static func Part2(_ data: [String] = finalMapFromPart1ForPart2) -> Int {
        let data = data.map { $0.map { $0 } }
        var map = [Point: Tile]()
        for (y, row) in data.enumerated() {
            for (x, tile) in row.enumerated() {
                map[Point(x: x, y: y)] = tile.tile
            }
        }
        var count = 0
        while map.first(where: { $0.value == .empty }) != nil {
            count += 1
            map.filter { $0.value == .oxygen }
                .map { $0.key }
                .flatMap { point in Direction.valid.map { point.offset(by: $0.offset) }}
                .map { ($0, map[$0]) }
                .filter { $0.1 == .empty }
                .map { $0.0 }
                .forEach { map[$0] = .oxygen }
            draw(map)
        }
        return count
    }
    
    private static func nextMove(_ map: [Point: Tile], _ droid: inout Droid) -> Move? {
        for _ in 0..<3 {
            droid.facing = droid.facing.rotate
            switch map[droid.offset] {
            case .wall?: break
            case .empty?: break
            case .oxygen?: break
            case .droid?: fatalError()
            case .unexplored?, nil: return droid.facing
            }
        }
        return nil
    }
    
    private static func breadth(_ map: [Point: Tile], _ graph: Graph<Point>, _ droid: Droid) -> Point? {
        var node = graph.nodes.first { $0.value == droid.position }!
        var toVisit = graph.links(node).map { $0.to }
        var visited = Set<Node>()
        while !toVisit.isEmpty {
            node = toVisit.removeFirst()
            visited.insert(node)
            if map[node.value] == .unexplored {
                return node.value
            } else {
                let nodes = Set(graph.links(node).map({ $0.to }))
                    .subtracting(visited)
                toVisit.append(contentsOf: nodes)
            }
        }
        return nil
    }
    
    private static func a_star(_ graph: Graph<Point>, _ start: Point, _ goal: Point) -> [Point] {
        var open = Set([start])
        var previous = [Point: Point]()
        // g = from start
        var g = graph.data(initial: Int.max)
        g[start] = 0
        // f = known + h
        var f = graph.data(initial: Int.max)
        f[start] = start.manhattanDistance(from: goal)
        
        var current = Point.zero
        while !open.isEmpty {
            current = open
                .map { ($0, f[$0]!) }
                .sorted { $0.1 < $1.1 }
                .first!.0
            if current == goal {
                break
            }
            open.remove(current)
            
            let node = graph.nodes.first { $0.value == current }!
            let neighbors = graph.links(node).map { $0.to.value }
            for neighbor in neighbors {
                if g[current]! < g[neighbor]! {
                    previous[neighbor] = current
                    g[neighbor] = g[current]
                    f[neighbor] = g[neighbor]! + neighbor.manhattanDistance(from: goal)
                    if !open.contains(neighbor) {
                        open.insert(neighbor)
                    }
                }
            }
        }
        // reconstruct
        var path = [current]
        while let next = previous[current] {
            current = next
            path.prepend(current)
        }
        return path
    }
    
    private static func draw(_ map: [Point: Tile], _ droid: Droid? = nil) {
        var map = map
        if let droid = droid {
            map[droid.position] = .droid
        }
        
        let points = map.map { $0.key }
        let x = points.map { $0.x }.sorted()
        let y = points.map { $0.y }.sorted()
        print("(\(x.first!),\(y.first!)) > (\(x.last!),\(y.last!))")
        for row in y.first!...y.last! {
            var string = ""
            for col in x.first!...x.last! {
                switch map[Point(x: col, y: row)] {
                case .wall?: string.append(Tile.wall.draw)
                case .empty?: string.append(Tile.empty.draw)
                case .oxygen?: string.append(Tile.oxygen.draw)
                case .droid?: string.append(droid?.facing.draw ?? Tile.droid.draw)
                case .unexplored?: string.append(Tile.unexplored.draw)
                case nil: string.append(" ")
                }
            }
            print(string)
        }
    }
    
    private static func unexplored(_ map: inout [Point: Tile], _ droid: Droid, _ graph: Graph<Point>) {
        var droid = droid
        for _ in 0..<4 {
            droid.facing = droid.facing.rotate
            if map[droid.offset] == nil {
                map[droid.offset] = .unexplored
                
                var ghost = droid
                ghost.position = ghost.offset
                let node = graph.nodes.first { $0.value == droid.position }!
                link(graph, node, ghost.position)
            }
        }
    }
    
    @discardableResult
    private static func link(_ graph: Graph<Point>, _ previous: Node, _ currentPoint: Point) -> Node {
        guard let existing = graph.nodes.first(where: { $0.value == currentPoint }) else {
            let current = graph.create(currentPoint)
            graph.link(previous, to: current)
            graph.link(current, to: previous)
            return current
        }
        return existing
    }
    
    private static func unlink(_ graph: Graph<Point>, _ droid: Droid, _ wall: Point) {
        guard let d = graph.nodes.first(where: { $0.value == droid.position }),
            let w = graph.nodes.first(where: { $0.value == wall }) else { return }
        graph.unlink(d, to: w)
        graph.unlink(w, to: d)
    }
    
    private static var finalMapFromPart1ForPart2: [String] {
        return """
 # ##### ############# # ######### #####
#.#.....#.............#.#.........#O....#
#.#.#.###.#####.#####.#.#.#####.#.#####.#
#.#.#.......#...#.#...#.....#...#...#...#
#.#.#########.###.#.#########.#####.#.##
#.#.#.#.......#.....#.......#.#.....#...#
#.#.#.#.#########.#####.###.#.#.#####.#.#
#.#.#.#.........#.#.....#.....#.#.#...#.#
#.#.#.#########.#.#.#.#########.#.#.###.#
#.#.....#...#...#...#.#...#.....#...#...#
#.#####.#.#.#.#####.###.#.#####.#####.#.#
#.#...#.#.#.#.....#.#...#.....#.......#.#
#.#.#.#.###.#####.#.#.#######.##########
#...#.#.......#...#.#.#.....#.#.........#
#.###.#######.#.###.#.###.#.#.#.#######.#
#.#.....#.....#...#.#...#.#.#.....#.....#
#.#.###.#.#######.#####.###.#######.###.#
#.#...#.#...#...#.......#...#...#...#...#
#.###.#####.###.#########.#.#.#.#.###.##
#.#.#.....#...#.........#.#.#.#.#.#.....#
#.#.###.#####.#.#######.#.#.###.#.#####.#
#...#...#...#.#.#.....#...#.....#...#...#
 ####.#.#.#.#.#.#.######## ####.###.###.#
#.....#.#.#...#.#...#.....#.......#...#.#
#.###.###.#####.###.#.###.#.#########.#.#
#.#...#...#.......#.#.#.#.#.#.......#.#.#
#.#####.## ####.###.#.#.#.###.#####.#.#.#
#.....#...#.....#...#.#.#.....#.#...#.#.#
 ####.###.#.###.#.###.#.#######.#.###.##
#...#...#...#...#.#...#.......#...#.....#
#.#.###.#####.###.###.#.#####.#.#####.#.#
#.#...#...#...#.#.....#.#...#.#.#...#.#.#
#.###.#.#.#.###.#######.#.###.#.#.#.###.#
#...#...#.#.....#.........#...#...#...#.#
 ##.###### ####.#.#########.#.#### ##.#.#
#...#.....#.....#.......#...#.....#.#...#
#.###.###.#.#############.#######.#.####
#.....#.#...#.............#.....#.#.....#
#.#####.#####.#############.###.#.#####.#
#.............#...............#.........#
 ############# ############### #########
""".newlineSplit()
    }
}

private extension Y2019Day15.Move {
    var direction: Direction {
        switch self {
        case .north: return .up
        case .east: return .right
        case .south: return .down
        case .west: return .left
        }
    }
    typealias Move = Y2019Day15.Move
    var rotate: Move {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        }
    }
    var draw: String {
        switch self {
        case .north: return "^"
        case .east: return ">"
        case .south: return "v"
        case .west: return "<"
        }
    }
}

private extension Y2019Day15.Tile {
    typealias Tile = Y2019Day15.Tile
    var draw: String {
        switch self {
        case .wall: return "#"
        case .empty: return "."
        case .oxygen: return "O"
        case .droid: return "@"
        case .unexplored: return "?"
        }
    }
}

private extension Character {
    typealias Tile = Y2019Day15.Tile
    var tile: Tile {
        switch self {
        case "#": return .wall
        case ".": return .empty
        case "O": return .oxygen
        default: return .wall
        }
    }
}

private extension Y2019Day15.Droid {
    var offset: Point {
        return position.offset(by: facing.direction.offset)
    }
}

private extension Direction {
    var move: Y2019Day15.Move {
        switch self {
        case .up: return .north
        case .right: return .east
        case .down: return .south
        case .left: return .west
        case .none: fatalError()
        }
    }
}

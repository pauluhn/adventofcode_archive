//
//  2019Day17.swift
//  aoc
//
//  Created by Paul Uhn on 1/11/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day17 {
    typealias Node = Graph<Point>.GraphNode<Point>
    
    enum Tile: String {
        case scaffold = "#"
        case open = "."
        case robot = "^"
        case newline = "\n"
    }
    
    enum Move: CustomStringConvertible {
        case forward(Int)
        case left
        case right
        
        var description: String {
            switch self {
            case .forward(let count): return "\(count)"
            case .left: return "L"
            case .right: return "R"
            }
        }
    }
    
    struct Robot {
        var position: Point
        var facing: Direction
        var offset: Point { return position.offset(by: facing.offset) }
    }
    
    struct Routine {
        let A: Function
        let B: Function
        let C: Function
        let main: [String]
        var ascii: [Ascii] {
            return main
                .joined(separator: ",")
                .compactMap { $0.asciiValue }
                .map { Ascii($0) } + [ Ascii(10) ] // newline
        }
    }
    
    struct Function {
        let moves: [Move]
        var ascii: [Ascii] {
            return moves
                .map { $0.description }
                .joined(separator: ",")
                .compactMap { $0.asciiValue }
                .map { Ascii($0) } + [ Ascii(10) ] // newline
        }
    }

    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)

        var outputs = [Int]()
        let intcode = IntcodeComputer(
            program: program,
            inputs: [],
            limitedMemory: false) {
                outputs.append($0)
        }
        _ = intcode.run()
        
        draw(outputs)
        
        var map = [Point: Tile]()
        var x = 0
        var y = 0
        for output in outputs {
            if output == 10 {
                y += 1
                x = 0
            } else {
                map[Point(x: x, y: y)] = Ascii(output).tile
                x += 1
            }
        }
        
        let intersections = map
            .filter { $0.value == .scaffold }
            .filter { scaffold in
                Direction.valid
                    .map { scaffold.key.offset(by: $0.offset) }
                    .filter { map[$0] == .scaffold }
                    .count == 4
            }
        
        return intersections.reduce(0) { $0 + $1.key.x * $1.key.y }
    }
    
    static func Part2(_ data: String) -> Int {
        var program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        program[0] = 2 // wake up vacuum robot
        /*
        let (graph, origin) = mapGraph()
        var robot = Robot(position: origin, facing: .up)
        var visited: Set<Point> = [robot.position]
        
        draw(graph, robot, visited)
        
        let moves: [Move] = [
            .left, .forward(10),
            .left, .forward(6),
            .right, .forward(10),
            .right, .forward(6),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(6),
            .right, .forward(8),
            .left, .forward(10),
            .left, .forward(6),
            
            // go all the way in
            .right, .forward(10),
            .left, .forward(10),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(10),
            .right, .forward(6),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(6),
            .right, .forward(8),
            .left, .forward(10),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(10),
            .right, .forward(6),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(6),
            .right, .forward(8),
            .left, .forward(10),
            .left, .forward(6),
            .right, .forward(10),
            .left, .forward(10),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(10),
            .right, .forward(6),
            .right, .forward(8),
            .right, .forward(8),
            .left, .forward(6),
            .right, .forward(8)
        ]
        for move in moves {
            switch move {
            case .left:
                robot.facing = robot.facing.turnLeft
            case .right:
                robot.facing = robot.facing.turnRight
            case .forward(let count):
                for _ in 0..<count {
                    robot.position = robot.offset
                    visited.insert(robot.position)
                }
            }
            draw(graph, robot, visited)
        }
        */
        let movement = Routine(
            A: Function(moves: [
                .left, .forward(10),
                .left, .forward(6),
                .right, .forward(10)]),
            B: Function(moves: [
                .right, .forward(6),
                .right, .forward(8),
                .right, .forward(8),
                .left, .forward(6),
                .right, .forward(8)]),
            C: Function(moves: [
                .left, .forward(10),
                .right, .forward(8),
                .right, .forward(8),
                .left, .forward(10)]),
            main: ["A", "B", "A", "C", "B", "C", "B", "A", "C", "B"])

        var command = ""
        var output = 0
        var intcode: IntcodeComputer!
        intcode = IntcodeComputer(
            program: program,
            limitedMemory: false) {
                output = $0
                
                if $0 != 10 {
                    command += Ascii($0).value
                    return
                    
                } else {
                    print(command)
                    let cmd = command
                    command = ""
                    
                    switch cmd {
                    case "Main:":
                        movement.ascii.forEach {
                            intcode.appendInput($0.int)
                        }

                    case "Function A:":
                        movement.A.ascii.forEach {
                            intcode.appendInput($0.int)
                        }

                    case "Function B:":
                        movement.B.ascii.forEach {
                            intcode.appendInput($0.int)
                        }

                    case "Function C:":
                        movement.C.ascii.forEach {
                            intcode.appendInput($0.int)
                        }

                    case "Continuous video feed?":
                        "n\n".map { $0.ascii }
                            .forEach { intcode.appendInput($0) }

                    default:
                        return
                    }
                }
        }
        var tick = false
        repeat { tick = intcode.tick() } while tick

        return output
    }
    
    private static func draw(_ map: [Int]) {
        let map = map
            .map { Ascii($0).tile.rawValue }
            .joined()
        print(map)
    }
    
    private static func draw(_ graph: Graph<Point>, _ robot: Robot, _ visited: Set<Point>) {
        var map = ""
        let xs = graph.nodes.map { $0.value.x }.sorted()
        let ys = graph.nodes.map { $0.value.y }.sorted()

        for y in ys.first! ... ys.last! {
            for x in xs.first! ... xs.last! {
                let point = Point(x: x, y: y)
                if point == robot.position {
                    map.append(robot.facing.draw)
                } else if visited.contains(point) {
                    map.append("x")
                } else if graph.nodes.first(where: { $0.value == point }) != nil {
                    map.append(Tile.scaffold.rawValue)
                } else {
                    map.append(Tile.open.rawValue)
                }
            }
            map.append(Tile.newline.rawValue)
        }
        print(map)
    }
    
    private static func mapGraph() -> (Graph<Point>, Point) {
        let map = mapFromPart1ForPart2()
            .newlineSplit()
            .map { $0.map { $0 } }
        let graph = Graph<Point>()
        var robot = Point.zero
        
        for (y, row) in map.enumerated() {
            for (x, tile) in row.enumerated() {
                switch Tile(rawValue: String(tile)) {
                case .robot?:
                    robot = Point(x: x, y: y)
                    fallthrough
                    
                case .scaffold?:
                    let node = graph.create(Point(x: x, y: y))
                    [Direction.up, .left]
                        .map { node.value.offset(by: $0.offset) }
                        .compactMap { offset in
                            graph.nodes.first { $0.value == offset }
                        }
                        .forEach {
                            graph.link(node, to: $0)
                            graph.link($0, to: node)
                        }
                    
                default: break
                }
            }
        }
        return (graph, robot)
    }
    
    private static func mapFromPart1ForPart2() -> String {
        return """
....................................#######..........
....................................#.....#..........
....................................#.....#..........
....................................#.....#..........
....................................#.....#..........
....................................#.....#..........
....................................#.....#..........
....................................#.....#..........
..................................#########..........
..................................#.#................
............................#########................
............................#.....#..................
............................#.....#..................
............................#.....#..................
..........................#########..................
..........................#.#........................
..........................#.#........................
..........................#.#........................
..........................#.###########..............
..........................#...........#..............
#########.##########^.....#.......#########..........
#.......#.#...............#.......#...#...#..........
#.......#.#...............#.......#...#...#..........
#.......#.#...............#.......#...#...#..........
#.......#.#...............#######.#...#...#..........
#.......#.#.....................#.#...#...#..........
###########.....................#.#...#######........
........#.......................#.#.......#.#........
........#######.................#.#.......###########
..............#.................#.#.........#.......#
..............#.........###########.........#.......#
..............#.........#.......#...........#.......#
..............#.........#.......#...........#.......#
..............#.........#.......#...........#.......#
..............#.........#.......###########.#########
..............#.........#.................#..........
..............###########.................#..........
..........................................#..........
....................................#########........
....................................#.....#..........
....................................#.....#..........
....................................#.....#..........
..................................#########..........
..................................#.#................
............................#########................
............................#.....#..................
............................#.....#..................
............................#.....#..................
............................#.....#..................
............................#.....#..................
............................#.....#..................
............................#.....#..................
............................#######..................
"""
    }
    
    private static func breadth(_ graph: Graph<Point>, _ robot: Robot, _ alreadyVisited: Set<Point>) -> Point? {
        var node = graph.nodes.first { $0.value == robot.position }!
        var toVisit = graph.links(node).map { $0.to }
        var visited = Set<Node>()
        while !toVisit.isEmpty {
            node = toVisit.removeFirst()
            visited.insert(node)
            if !alreadyVisited.contains(node.value) {
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
}

private extension Ascii {
    typealias Tile = Y2019Day17.Tile
    var tile: Tile {
        return Tile(rawValue: value) ?? .newline
    }
}

private extension Direction {
    var draw: String {
        switch self {
        case .up: return "^"
        case .right: return ">"
        case .down: return "v"
        case .left: return "<"
        case .none: return "?"
        }
    }
}

private extension Graph where T == Point {
    typealias Robot = Y2019Day17.Robot
    func robot(_ robot: Robot) -> Node? {
        return nodes.first { $0.value == robot.position }
    }
}

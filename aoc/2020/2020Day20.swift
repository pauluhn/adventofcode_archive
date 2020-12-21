//
//  2020Day20.swift
//  aoc
//
//  Created by Paul U on 12/20/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day20 {

    struct Tile: Hashable, CustomStringConvertible {
        enum Color: Character {
            case dark = "#"
            case light = "."
        }
        enum Border: Int, CaseIterable {
            case top
            case right
            case bottom
            case left
        }
        enum Flip {
            case horizontal
            case vertical
        }
        let id: Int
        private(set) var map: [[Color]]
        var borders: [Int] {
            let b = Border.allCases.map { border(at: $0) }
            let r = Border.allCases.map { border(at: $0, reversed: true) }
            return b + r
        }
        var description: String {
            return map.map { $0.map { $0.rawValue }.string }.joined(separator: "\n")
        }
        
        init?(_ data: String) {
            let data = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
            guard data.count == 11 else { return nil }
            let regex = try! NSRegularExpression(pattern: "^Tile ([0-9]+):$")
            guard let match = regex.firstMatch(in: data[0], options: [], range: NSRange(location: 0, length: data[0].count)) else { return nil }
            id = data[0].match(match, at: 1).int
            map = data[1 ..< data.count].map { $0.compactMap(Color.init) }
        }
        func border(at side: Border, reversed: Bool = false) -> Int {
            let binaryString = { side -> String in
                switch side {
                case .top: return map.first!.binary
                case .bottom: return map.last!.binary
                case .left: return map.map { $0.first! }.binary
                case .right: return map.map { $0.last! }.binary
                }
            }(side)
            guard reversed else { return binaryString.binaryInt }
            return binaryString.reversed().string.binaryInt
        }
        /// Rotate to `.left` or `.right` by 90 degrees
        mutating func rotate(to side: Border) {
            guard side == .left || side == .right else { fatalError() }
            let loops = side == .right ? 1 : 3
            for _ in 0 ..< loops {
                var cache = map
                for (y, row) in map.enumerated() {
                    for (x, color) in row.enumerated() {
                        cache[x][9 - y] = color
                    }
                }
                map = cache
            }
        }
        /// Rotate to `.left` or `.right` by 90 degrees
        mutating func flip(in direction: Flip) {
            var cache = map
            for (y, row) in map.enumerated() {
                for (x, color) in row.enumerated() {
                    switch direction {
                    case .horizontal: cache[y][9 - x] = color
                    case .vertical: cache[9 - y][x] = color
                    }
                }
            }
            map = cache
        }
    }
    
    private static func parse(_ data: String) -> Graph<Tile> {
        let data = data.components(separatedBy: "\n\n")
        let graph = Graph<Tile>()
        let tiles = data.compactMap(Tile.init)
        for tile in tiles {
            let borders = Set(tile.borders)
            let node = graph.create(tile)
            graph.nodes
                .filter { tile.id != $0.value.id }
                .filter { !borders.intersection($0.value.borders).isEmpty }
                .forEach {
                    graph.link(node, to: $0)
                    graph.link($0, to: node)
                }
        }
        return graph
    }
    
    static func Part1(_ data: String) -> Int {
        let graph = parse(data)        
        return graph.nodes
            .filter { graph.links($0).count == 2 }
            .map { $0.value.id }
            .reduce(1, *)
    }

    static func Part2(_ data: String) -> Int {
        let graph = parse(data)
        let side = graph.nodes.count.sqrt
        var puzzle = [Point: Tile]()
        // solve puzzle
        for y in 0 ..< side {
            for x in 0 ..< side {
                let point = Point(x: x, y: y)
                if point == .zero {
                    // first corner
                    let corner = graph.corners.first!
                    var tile = corner.value
                    var n1 = graph.links(corner).first!.to.value
                    let (sb1, _) = match(tile, to: &n1)
                    var n2 = graph.links(corner).last!.to.value
                    let (sb3, _) = match(tile, to: &n2)
                    let b = [sb1, sb3].sorted { $0.rawValue < $1.rawValue }
                    if b == [.top, .right] { tile.rotate(to: .right) } // example
                    else if b == [.bottom, .left] { tile.rotate(to: .left) } // puzzle input
                    puzzle[point] = tile
                
                } else if point.x == 0 {
                    // left
                    let top = puzzle[Point(x: x, y: y - 1)]!
                    let b = top.border(at: .bottom)
                    var tile = graph.links
                        .filter { $0.from.value.id == top.id }
                        .first { $0.to.value.borders.contains(b) }
                        .map { $0.to.value }!
                    while true {
                        let (sb1, sb2) = match(top, to: &tile)
                        guard sb1 == .bottom else { fatalError() }
                        if sb2 == .top { break }
                        tile.rotate(to: .right)
                    }
                    puzzle[point] = tile
                
                } else {
                    let left = puzzle[Point(x: x - 1, y: y)]!
                    let b = left.border(at: .right)
                    var tile = graph.links
                        .filter { $0.from.value.id == left.id }
                        .first { $0.to.value.borders.contains(b) }
                        .map { $0.to.value }!
                    while true {
                        let (sb1, sb2) = match(left, to: &tile)
                        guard sb1 == .right else { fatalError() }
                        if sb2 == .left { break }
                        tile.rotate(to: .right)
                    }
                    puzzle[point] = tile
                }
            }
        }
        // one image
        var image = [Point]()
        for y in 0 ..< side {
            for x in 0 ..< side {
                let tile = puzzle[Point(x: x, y: y)]!
                for j in 0 ..< 8 {
                    for i in 0 ..< 8 {
                        if tile.map[j + 1][i + 1] == .dark {
                            image += [Point(x: x * 8 + i, y: y * 8 + j)]
                        }
                    }
                }
            }
        }
        // search
        let pattern = seaMonster()
        let pc = pattern.count
        let xm = pattern.max { $0.x < $1.x }!.x
        let ym = pattern.max { $0.y < $1.y }!.y
        var results = 0
        for _ in 0 ..< 2 {
            for _ in 0 ..< 4 {
                let imageSet = Set(image)
                var count = 0
                
                for y in 0 ..< side * 8 - ym {
                    for x in 0 ..< side * 8 - xm {
                        let p = pattern.map { $0 + Point(x: x, y: y) }
                        if imageSet.intersection(p).count == pc {
                            count += 1
                        }
                    }
                }
                // rotate
                var cache = [Point]()
                for p in image {
                    cache += [Point(x: side * 8 - p.y, y: p.x)]
                }
                image = cache
                
                results = max(results, count)
            }
            var cache = [Point]()
            for p in image {
                cache += [Point(x: side * 8 - p.x, y: p.y)]
            }
            image = cache
        }
        
        return image.count - results * pattern.count
    }
    
    private static func match(_ tile: Tile, to other: inout Tile, round: Int = 0) -> (Tile.Border, Tile.Border) {
        switch round {
        case 0: break
        case 1: other.flip(in: .horizontal)
        case 2: other.flip(in: .vertical)
        default: fatalError()
        }
        let tileBorder = Tile.Border.allCases.map { ($0, tile.border(at: $0)) }
        let otherBorder = Tile.Border.allCases.map { ($0, other.border(at: $0)) }
        
        for (b, n) in tileBorder {
            for (c, m) in otherBorder where n == m {
                return (b, c)
            }
        }
        return match(tile, to: &other, round: round + 1)
    }
    
    private static func seaMonster() -> [Point] {
        let data = """
                  #
#    ##    ##    ###
 #  #  #  #  #  #
""".newlineSplit()
        var points = [Point]()
        for (y, row) in data.enumerated() {
            for (x, c) in row.enumerated() where c == "#" {
                points += [Point(x: x, y: y)]
            }
        }
        return points
    }
}

private extension Array where Element == Y2020Day20.Tile.Color {
    var binary: String {
        self.map { $0 == .dark ? "1" : "0" }.joined()
    }
}

private extension Graph where T == Y2020Day20.Tile {
    var corners: [Node] {
        nodes.filter { links($0).count == 2 }
    }
    var edges: [Node] {
        nodes.filter { links($0).count == 3 }
    }
    var insides: [Node] {
        nodes.filter { links($0).count == 4 }
    }
}

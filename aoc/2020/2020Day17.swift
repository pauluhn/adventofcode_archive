//
//  2020Day17.swift
//  aoc
//
//  Created by Paul U on 12/17/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day17 {

    enum Tile: Character {
        case active = "#"
        case inactive = "."
    }
    
    static func Part1(_ data: [String]) -> Int {
        // parse into tile
        let data = data
            .map { $0.compactMap(Tile.init) }
            .filter { !$0.isEmpty }
        // hashmap
        var map = [Point3D: Tile]()
        for (y, row) in data.enumerated() {
            for (x, tile) in row.enumerated() {
                let point = Point3D(x: x, y: y, z: 0)
                map[point] = tile
            }
        }
        // loop
        for _ in 0 ..< 6 {
            // expand map
            let cache = expand3D(map)
            map = cache.map { data -> (Point3D, Tile) in
                // adjacent
                let active = data.key
                    .adjacent
                    .map { cache[$0] }
                    .filter { $0 == .active }
                    .count
                // rules
                if data.value == .active, 2...3 ~= active {
                    return (data.key, .active)
                } else if data.value == .inactive, 3 == active {
                    return (data.key, .active)
                }
                return (data.key, .inactive)
            }
            // update map
            .reduce(into: [Point3D: Tile]()) {
                $0[$1.0] = $1.1
            }
        }
        return map
            .filter { $0.value == .active }
            .count
    }
    
    static func Part2(_ data: [String]) -> Int {
        // parse into tile
        let data = data
            .map { $0.compactMap(Tile.init) }
            .filter { !$0.isEmpty }
        // hashmap
        var map = [Point4D: Tile]()
        for (y, row) in data.enumerated() {
            for (x, tile) in row.enumerated() {
                let point = Point4D(x: x, y: y, z: 0, w: 0)
                map[point] = tile
            }
        }
        // loop
        for _ in 0 ..< 6 {
            // expand map
            let cache = expand4D(map)
            map = cache.map { data -> (Point4D, Tile) in
                // adjacent
                let active = data.key
                    .adjacent
                    .map { cache[$0] }
                    .filter { $0 == .active }
                    .count
                // rules
                if data.value == .active, 2...3 ~= active {
                    return (data.key, .active)
                } else if data.value == .inactive, 3 == active {
                    return (data.key, .active)
                }
                return (data.key, .inactive)
            }
            // update map
            .reduce(into: [Point4D: Tile]()) {
                $0[$1.0] = $1.1
            }
        }
        return map
            .filter { $0.value == .active }
            .count
    }
    
    private static func expand3D(_ map: [Point3D: Tile]) -> [Point3D: Tile] {
        let x = map.map { $0.key.x }
        let y = map.map { $0.key.y }
        let z = map.map { $0.key.z }
        
        let xmin = x.min()! - 1
        let xmax = x.max()! + 1
        let ymin = y.min()! - 1
        let ymax = y.max()! + 1
        let zmin = z.min()! - 1
        let zmax = z.max()! + 1
        
        let xr = (xmin ... xmax).map { $0 }
        let yr = (ymin ... ymax).map { $0 }
        let zr = (zmin ... zmax).map { $0 }
        
        var points = generate3D(xr, yr, [zmax])
        points.formUnion(generate3D(xr, yr, [zmin]))
        points.formUnion(generate3D(xr, [ymax], zr))
        points.formUnion(generate3D(xr, [ymin], zr))
        points.formUnion(generate3D([xmax], yr, zr))
        points.formUnion(generate3D([xmin], yr, zr))

        var map = map
        for point in points {
            map[point] = .inactive
        }
        return map
    }
    
    private static func expand4D(_ map: [Point4D: Tile]) -> [Point4D: Tile] {
        let x = map.map { $0.key.x }
        let y = map.map { $0.key.y }
        let z = map.map { $0.key.z }
        let w = map.map { $0.key.w }

        let xmin = x.min()! - 1
        let xmax = x.max()! + 1
        let ymin = y.min()! - 1
        let ymax = y.max()! + 1
        let zmin = z.min()! - 1
        let zmax = z.max()! + 1
        let wmin = w.min()! - 1
        let wmax = w.max()! + 1

        let xr = (xmin ... xmax).map { $0 }
        let yr = (ymin ... ymax).map { $0 }
        let zr = (zmin ... zmax).map { $0 }
        let wr = (wmin ... wmax).map { $0 }

        var points = generate4D(xr, yr, [zmax], wr)
        points.formUnion(generate4D(xr, yr, [zmin], wr))
        points.formUnion(generate4D(xr, [ymax], zr, wr))
        points.formUnion(generate4D(xr, [ymin], zr, wr))
        points.formUnion(generate4D([xmax], yr, zr, wr))
        points.formUnion(generate4D([xmin], yr, zr, wr))
        points.formUnion(generate4D(xr, yr, zr, [wmax]))
        points.formUnion(generate4D(xr, yr, zr, [wmin]))

        var map = map
        for point in points {
            map[point] = .inactive
        }
        return map
    }
    
    private static func generate3D(_ xr: [Int], _ yr: [Int], _ zr: [Int]) -> Set<Point3D> {
        var points = Set<Point3D>()
        for x in xr {
            for y in yr {
                for z in zr {
                    points.insert(Point3D(x: x, y: y, z: z))
                }
            }
        }
        return points
    }

    private static func generate4D(_ xr: [Int], _ yr: [Int], _ zr: [Int], _ wr: [Int]) -> Set<Point4D> {
        var points = Set<Point4D>()
        for x in xr {
            for y in yr {
                for z in zr {
                    for w in wr {
                        points.insert(Point4D(x: x, y: y, z: z, w: w))
                    }
                }
            }
        }
        return points
    }
}

private extension Point3D {
    var adjacent: [Point3D] {
        let directions = Direction3D.allCases
        var points = directions.map { self.offset(by: 1, toward: $0) }
        
        let tb: [Direction3D] = [.top, .bottom]
        let fb: [Direction3D] = [.front, .back]
        let lr: [Direction3D] = [.left, .right]
        let fblr: [Direction3D] = fb + lr

        typealias Tuple3D = (Direction3D, Direction3D)
        let tuple1 = tb.flatMap { tb -> [Tuple3D] in
            fblr.map { (tb, $0) }
        }
        let tuple2 = fb.flatMap { fb -> [Tuple3D] in
            lr.map { (fb, $0) }
        }
        points += [tuple1, tuple2].flatMap { tuples -> [Point3D] in
            tuples.map {
                self.offset(by: 1, toward: $0.0)
                    .offset(by: 1, toward: $0.1)
            }
        }
        
        typealias Triple3D = (Direction3D, Direction3D, Direction3D)
        let triple = tb.flatMap { tb -> [Triple3D] in
            tuple2.map { (tb, $0.0, $0.1) }
        }
        points += triple.map {
            self.offset(by: 1, toward: $0.0)
                .offset(by: 1, toward: $0.1)
                .offset(by: 1, toward: $0.2)
        }
        
        return points
    }
}

private extension Point4D {
    var adjacent: Set<Point4D> {
        var points = Set<Point4D>()
        for x in (self.x - 1 ... self.x + 1) {
            for y in (self.y - 1 ... self.y + 1) {
                for z in (self.z - 1 ... self.z + 1) {
                    for w in (self.w - 1 ... self.w + 1) {
                        points.insert(Point4D(x: x, y: y, z: z, w: w))
                    }
                }
            }
        }
        return points.removing(self)
    }
}

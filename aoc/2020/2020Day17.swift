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
        let data = data
            .map { $0.compactMap(Tile.init) }
            .filter { !$0.isEmpty }
        
        var map = [Point3D: Tile]()
        for (y, row) in data.enumerated() {
            for (x, tile) in row.enumerated() {
                let point = Point3D(x: x, y: y, z: 0)
                map[point] = tile
            }
        }
        
        for _ in 0 ..< 6 {
            let cache = expand(map)
            map = cache.map { data -> (Point3D, Tile) in
                let active = data.key
                    .adjacent
                    .map { cache[$0] }
                    .filter { $0 == .active }
                    .count
                
                if data.value == .active, 2...3 ~= active {
                    return (data.key, .active)
                } else if data.value == .inactive, 3 == active {
                    return (data.key, .active)
                }
                return (data.key, .inactive)
            }
            .reduce(into: [Point3D: Tile]()) {
                $0[$1.0] = $1.1
            }
        }
        return map
            .filter { $0.value == .active }
            .count
    }
    
    private static func expand(_ map: [Point3D: Tile]) -> [Point3D: Tile] {
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
        
        var points = generate(xr, yr, [zmax])
        points.formUnion(generate(xr, yr, [zmin]))
        points.formUnion(generate(xr, [ymax], zr))
        points.formUnion(generate(xr, [ymin], zr))
        points.formUnion(generate([xmax], yr, zr))
        points.formUnion(generate([xmin], yr, zr))

        var map = map
        for point in points {
            map[point] = .inactive
        }
        return map
    }
    
    private static func generate(_ xr: [Int], _ yr: [Int], _ zr: [Int]) -> Set<Point3D> {
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

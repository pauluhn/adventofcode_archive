//
//  2019Day12.swift
//  aoc
//
//  Created by Paul Uhn on 12/15/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day12 {

    class Moon {
        let id: UUID
        private var position: Point3D
        private var velocity = Point3D.zero
        
        private var pot: Int { return position.sum }
        private var kin: Int { return velocity.sum }
        var total: Int { return pot * kin }
        
        init?(id: UUID, _ data: String) {
            self.id = id
            
            let regex = try! NSRegularExpression(pattern: "^<x=(-?\\d+), y=(-?\\d+), z=(-?\\d+)>$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            
            let x = data.match(match, at: 1).int
            let y = data.match(match, at: 2).int
            let z = data.match(match, at: 3).int
            position = Point3D(x: x, y: y, z: z)
        }
        
        func gravity(other moon: Moon) {
            func compute(_ mine: Int, _ other: Int) -> Int {
                guard mine != other else { return 0 }
                return mine > other ? -1 : 1
            }
            let x = compute(position.x, moon.position.x)
            let y = compute(position.y, moon.position.y)
            let z = compute(position.z, moon.position.z)
            velocity += Point3D(x: x, y: y, z: z)
        }
        
        func move() {
            position += velocity
        }
    }
    
    static func Part1(_ data: [String], _ steps: Int) -> Int {
        let moons = data.compactMap { Moon(id: UUID(), $0) }
        
        for i in 0..<steps {
            for moon in moons {
                let others = moons.removing(moon)
                others.forEach { moon.gravity(other: $0) }
            }
            moons.forEach { $0.move() }
            
            print("\nAfter \(i + 1) steps:")
            moons.forEach { print($0) }
        }
        
        return moons.reduce(0) { $0 + $1.total }
    }
}

extension Y2019Day12.Moon: Equatable, CustomStringConvertible {
    typealias Moon = Y2019Day12.Moon
    static func == (lhs: Moon, rhs: Moon) -> Bool {
        return lhs.id == rhs.id
    }
    var description: String {
        return "pos=<x=\(position.x), y=\(position.y), z=\(position.z)>, vel=<x=\(velocity.x), y=\(velocity.y), z=\(velocity.z)>"
    }
}

private extension Point3D {
    var sum: Int {
        return abs(x) + abs(y) + abs(z)
    }
}

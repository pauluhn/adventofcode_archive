//
//  2019Day12.swift
//  aoc
//
//  Created by Paul Uhn on 12/15/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day12 {

    struct Moon {
        let id: UUID
        private(set) var position: Point3D
        private(set) var velocity = Point3D.zero
        
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
        
        mutating func gravity(other moon: Moon) {
            func compute(_ mine: Int, _ other: Int) -> Int {
                guard mine != other else { return 0 }
                return mine > other ? -1 : 1
            }
            let x = compute(position.x, moon.position.x)
            let y = compute(position.y, moon.position.y)
            let z = compute(position.z, moon.position.z)
            velocity += Point3D(x: x, y: y, z: z)
        }
        
        mutating func move() {
            position += velocity
        }
    }
    
    static func Part1(_ data: [String], _ steps: Int) -> Int {
        var moons = data.compactMap { Moon(id: UUID(), $0) }
        
        for i in 0..<steps {
            for i in 0..<moons.count {
                let others = moons.removing(moons[i])
                others.forEach { moons[i].gravity(other: $0) }
            }
            for i in 0..<moons.count {
                moons[i].move()
            }
            
            print("\nAfter \(i + 1) steps:")
            moons.forEach { print($0) }
        }
        
        return moons.reduce(0) { $0 + $1.total }
    }

    static func Part2(_ data: [String]) -> Int {
        var moons = data.compactMap { Moon(id: UUID(), $0) }
        var finder = PatternFinder()
        
        while true {
            for i in 0..<moons.count {
                let others = moons.removing(moons[i])
                others.forEach { moons[i].gravity(other: $0) }
            }
            for i in 0..<moons.count {
                moons[i].move()
            }
            
            if finder.add(moons) {
                var counter = FactorCount()
                finder.factors.forEach {
                    counter.add($0)
                }
                print(counter.counter)
                return counter.counter.reduce(1) {
                    var value = 1
                    for _ in 0..<$1.value {
                        value *= $1.key
                    }
                    return $0 * value
                }
            }
        }
    }
    
    private struct PatternFinder {
        private struct Pattern {
            enum State { case building, matching, done }
            var state = State.building
            var items = [Int]()
            var count = 0
            
            mutating func add(_ item: Int) {
                switch state {
                case .building:
                    if let first = items.first, first == item {
                        state = .matching
                        count = items.count
                    }
                    items.append(item)
                    
                case .matching:
                    if items.count - count == count {
                        state = .done
                    } else if items[items.count - count] != item {
                        state = .building
                    }
                    items.append(item)
                    
                case .done: break
                }
            }
        }
        
        private struct MoonPattern {
            var patterns = Array(repeating: Pattern(), count: 6)
            var factors = [Int]()
            
            mutating func add(_ moon: Moon) -> Bool {
                patterns[0].add(moon.position.x)
                patterns[1].add(moon.position.y)
                patterns[2].add(moon.position.z)
                patterns[3].add(moon.velocity.x)
                patterns[4].add(moon.velocity.y)
                patterns[5].add(moon.velocity.z)
                
                factors = patterns
                    .filter { $0.state == .done }
                    .map { $0.count }
                return factors.count == 6
            }
        }
        
        private var moons = Array(repeating: MoonPattern(), count: 4)
        private(set) var factors = Set<Int>()
        
        mutating func add(_ moons: [Moon]) -> Bool {
            let a = self.moons[0].add(moons[0])
            let b = self.moons[1].add(moons[1])
            let c = self.moons[2].add(moons[2])
            let d = self.moons[3].add(moons[3])
            
            if a, b, c, d {
                self.moons.forEach { $0.factors.forEach { factors.insert($0) }}
                return true
            } else {
                return false
            }
        }
    }
    
    private struct FactorCount {
        private(set) var counter = [Int: Int]()
        
        mutating func add(_ input: Int) {
            let factors = Dictionary(grouping: Factors(input)) { $0 }
            for factor in factors {
                if let count = counter[factor.key] {
                    if count < factor.value.count {
                        counter[factor.key] = factor.value.count // update
                    }
                } else {
                    counter[factor.key] = factor.value.count // new
                }
            }
        }
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

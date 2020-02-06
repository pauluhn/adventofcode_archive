//
//  2019Day18.swift
//  aoc
//
//  Created by Paul Uhn on 1/18/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day18 {
    
    typealias ItemLocations = [Character: Point]
    typealias Key = Character
    typealias Door = Character
    
    enum Tile {
        case entrance
        case open
        case wall
        case key(Key)
        case door(Door)
    }
    
    struct TreeNode: Hashable {
        let keys: ItemLocations
        let doors: ItemLocations
    }
    
    struct TreeNodeNext {
        let key: Key
        let path: [Point]
        var door: Door { return key.uppercased().first! }
    }
    
    struct TreeWalk {
        let keys: [Key]
        let steps: Int
    }

    static func Part1(_ data: [String]) -> Int {
        let (graph, entrance, keys, doors) = mapGraph(data)
        let memo: NSMutableDictionary = [:]

        let root = TreeNode(keys: keys, doors: doors)
        let leaves = findNext(graph, start: entrance, keys: keys, doors: doors)
        
        let shortest = walk(graph, memo, from: root, to: leaves)
        print("\(shortest.keys.map(String.init).joined(separator: ",")) = \(shortest.steps)")
        return shortest.steps
    }
    
    private static func mapGraph(_ data: [String]) -> (Graph<Point>, Point, ItemLocations, ItemLocations) {
        let map = data.map { $0.map { $0 }}
        let graph = Graph<Point>()
        var entrance = Point.zero
        var keys = ItemLocations()
        var doors = ItemLocations()

        @discardableResult
        func createAndLink(_ point: Point) -> Point {
            let node = graph.create(point)
            graph.link(node, in: .up, .left)
            return point
        }
        
        for (y, row) in map.enumerated() {
            for (x, value) in row.enumerated() {
                switch value.tile {
                case .entrance:
                    entrance = Point(x: x, y: y)
                    createAndLink(entrance)
                    
                case .open:
                    createAndLink(Point(x: x, y: y))
                    
                case .wall:
                    break
                    
                case .key(let key):
                    keys[key] = createAndLink(Point(x: x, y: y))
                    
                case .door(let door):
                    doors[door] = createAndLink(Point(x: x, y: y))
                }
            }
        }
        return (graph, entrance, keys, doors)
    }
    
    private static func findNext(_ graph: Graph<Point>, start: Point, keys: ItemLocations, doors: ItemLocations) -> [TreeNodeNext] {
        let keyLocations = keys.map { ($0.key, $0.value) }
        let doorLocations = doors.map { $0.value }
        return keys.map { ($0.key, graph.a_star(start: start, goal: $0.value)) }
            .filter { Set($0.1).intersection(doorLocations).isEmpty } // can't go thru doors
            .filter { tuple in
                let otherKeyLocations = keyLocations.filter { $0.0 != tuple.0 }.map { $0.1 }
                return Set(tuple.1).intersection(otherKeyLocations).isEmpty } // don't go thru other keys
            .sorted { $0.1.count < $1.1.count }
            .map { TreeNodeNext(key: $0.0, path: $0.1) }
    }
    
    private static func walk(_ graph: Graph<Point>, _ memo: NSMutableDictionary, from parent: TreeNode, to children: [TreeNodeNext]) -> TreeWalk {
        return walk(graph, memo, parent, children, [])
    }
    
    private static func walk(_ graph: Graph<Point>, _ memo: NSMutableDictionary, _ parent: TreeNode, _ children: [TreeNodeNext], _ list: [Key]) -> TreeWalk {
        guard !children.isEmpty else {
            print("\(list.map(String.init).joined(separator: ","))")
            return TreeWalk(keys: list, steps: 0)
        }
        
        func memoKey(key: Key?, rest: [Key]) -> String? {
            guard let key = key else { return nil }
            let all = [key] + rest
            return all.map(String.init).joined()
        }
        if let key = memoKey(key: list.last, rest: parent.keys.keys.sorted()),
            let value = memo[key] as? TreeWalk {
                return value
        }
        
        var shortest = TreeWalk(keys: list, steps: Int.max)
        for child in children {
            let steps = child.path.count - 1
            let keys = parent.keys.without(child.key)
            let doors = parent.doors.without(child.door)
            let node = TreeNode(keys: keys, doors: doors)
            // recursion
            let leaves = findNext(graph, start: child.path.last!, keys: keys, doors: doors)
            let result = walk(graph, memo, node, leaves, list + [child.key])
            if result.steps + steps < shortest.steps {
                shortest = TreeWalk(keys: result.keys, steps: result.steps + steps)
            }
        }
        if let key = memoKey(key: list.last, rest: parent.keys.keys.sorted()) {
            memo.setValue(shortest, forKey: key)
        }
        return shortest
    }
}

private extension Character {
    typealias Tile = Y2019Day18.Tile
    var tile: Tile {
        switch self {
        case "@": return .entrance
        case ".": return .open
        case "#": return .wall
        case "a"..."z": return .key(self)
        case "A"..."Z": return .door(self)
        default: fatalError()
        }
    }
}

private extension Y2019Day18.ItemLocations {
    typealias ItemLocations = Y2019Day18.ItemLocations
    func without(_ key: Character) -> ItemLocations {
        var items = self
        items.removeValue(forKey: key)
        return items
    }
}

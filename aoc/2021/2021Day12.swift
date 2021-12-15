//
//  2021Day12.swift
//  aoc
//
//  Created by Paul U on 12/12/21.
//  Copyright © 2021 Mojio. All rights reserved.
//

import Foundation

struct Y2021Day12 {

    enum Cave: Hashable {
        case start
        case end
        case small(String)
        case big(String)
    }

    static func Part1(_ data: [String]) -> Int {
        let (links, counts) = parse(data)
        var paths = Set<[Cave]>()
        path(.start, links, counts, [.start], &paths)
        return paths.count
    }

    static func Part2(_ data: [String]) -> Int {
        let (links, counts) = parse(data)
        var paths = Set<[Cave]>()

        counts.keys.forEach {
            var copy = counts
            copy[$0] = 2
            path(.start, links, copy, [.start], &paths)
        }
        return paths.count
    }

    private static func path(_ current: Cave, _ links: Links, _ count: Counts, _ path: [Cave], _ paths: inout Set<[Cave]>) {
        if current == .end {
            paths.insert(path)
            return
        }
        guard let next = links[current] else { return }
        var links = links
        if current == .start {
            links[current] = nil
        }
        var copy = count
        if let value = copy[current] {
            copy[current] = value - 1
            if value <= 1 {
                links[current] = nil
            }
        }
        next.forEach {
            self.path($0, links, copy, path + [$0], &paths)
        }
    }

    typealias Links = [Cave: Set<Cave>]
    private static func parseLinks(_ data: [String]) -> Links {
        let data: [[Cave]] = data.map {
            let links = $0
                .split(separator: "-")
                .map { value -> Cave in
                    switch value {
                    case "start": return .start
                    case "end": return .end
                    default: break
                    }
                    switch value.first! {
                    case "a"..."z": return .small(String(value))
                    case "A"..."Z": return .big(String(value))
                    default: fatalError()
                    }
                }
            return links
        }
        var links = [Cave: Set<Cave>]()
        data.forEach { link in
            var set = links[link.first!, default: Set<Cave>()]
            set.insert(link.last!)
            links[link.first!] = set

            var set2 = links[link.last!, default: Set<Cave>()]
            set2.insert(link.first!)
            links[link.last!] = set2
        }
        return links
    }

    typealias Counts = [Cave: Int]
    private static func parse(_ data: [String]) -> (Links, Counts) {
        let links = parseLinks(data)
        let keys = links.keys.filter {
            if case .small = $0 { return true }
            return false
        }
        let counts = Array(repeating: 1, count: keys.count)
        let keyCounts = Dictionary(uniqueKeysWithValues: zip(keys, counts))
        return (links, keyCounts)
    }
}

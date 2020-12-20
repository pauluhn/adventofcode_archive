//
//  2020Day20.swift
//  aoc
//
//  Created by Paul U on 12/20/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day20 {

    struct Tile: Hashable {
        enum Color: Character {
            case dark = "#"
            case light = "."
        }
        let id: Int
        let map: [[Color]]
        let borders: [Int]
        
        init?(_ data: String) {
            let data = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
            guard data.count == 11 else { return nil }
            let regex = try! NSRegularExpression(pattern: "^Tile ([0-9]+):$")
            guard let match = regex.firstMatch(in: data[0], options: [], range: NSRange(location: 0, length: data[0].count)) else { return nil }
            id = data[0].match(match, at: 1).int
            map = data[1 ..< data.count].map { $0.compactMap(Color.init) }
            let top = map[0].binary
            let bottom = map[map.count - 1].binary
            let left = map.map { $0[0] }.binary
            let right = map.map { $0[$0.count - 1] }.binary
            let borders = [top, right, bottom, left]
            let reversed = borders.map { $0.reversed().string }
            self.borders = (borders + reversed).map { $0.binaryInt }
        }
    }
    
    static func Part1(_ data: String) -> Int {
        let data = data.components(separatedBy: "\n\n")
        let graph = Graph<Tile>()

        let tiles = data.compactMap(Tile.init)
        for tile in tiles {
            let borders = Set(tile.borders)
            let node = graph.create(tile)
            graph.nodes
                .filter { tile.id != $0.value.id }
                .filter {
                    borders
                        .intersection($0.value.borders)
                        .count > 0
                }
                .forEach {
                    graph.link(node, to: $0)
                    graph.link($0, to: node)
                }
        }
        
        return graph.nodes
            .filter { graph.links($0).count == 2 }
            .map { $0.value.id }
            .reduce(1, *)
    }
}

private extension Array where Element == Y2020Day20.Tile.Color {
    var binary: String {
        self.map { $0 == .dark ? "1" : "0" }.joined()
    }
}

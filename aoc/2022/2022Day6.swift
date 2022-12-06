//
//  2022Day6.swift
//  aoc
//
//  Created by Paul U on 12/6/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day6 {

    struct Datastream {
        private let queue: Queue<Character>
        private(set) var premarker: [Character]
        private(set) var marker: [Character]
    }
    
    static func Part1(_ data: String) -> Int {
        let stream = Datastream(data)
        return stream.premarker.count + stream.marker.count
    }

    static func Part2(_ data: String) -> Int {
        let stream = Datastream(data, markerLength: 14)
        return stream.premarker.count + stream.marker.count
    }
}

private extension Y2022Day6.Datastream {
    init(_ buffer: String, markerLength: Int = 4) {
        queue = Queue(buffer.map { $0 })

        var premarker = [Character]()
        var marker = [Character]()
        while Set(marker).count < markerLength {
            guard let packet = queue.pop() else { fatalError() }
            marker.append(packet)

            if marker.count > markerLength {
                let packet = marker.removeFirst()
                premarker.append(packet)
            }
        }
        self.premarker = premarker
        self.marker = marker
    }
}

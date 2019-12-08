//
//  2019Day8.swift
//  aoc
//
//  Created by Paul Uhn on 12/8/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day8 {
    
    struct Image {
        let width: Int
        let height: Int
        
        struct Layer {
            let id: Int
            var image: [Int]
        }
        private(set) var layers = [Layer]()
        
        init(_ width: Int, _ height: Int, _ data: String) {
            self.width = width
            self.height = height
            for (n, c) in data.enumerated() {
                if n % (width * height) == 0 {
                    layers.append(Layer(id: layers.count, image: []))
                }
                layers[layers.count - 1].image.append(c.int)
            }
        }
    }
    
    static func Part1(_ data: String) -> Int {
        let testImage = Image(3, 2, "123456789012")
        assert(testImage.width == 3)
        assert(testImage.height == 2)
        assert(testImage.layers.count == 2)
        
        let image = Image(25, 6, data)
        let layer = image.layers
            .map { ($0.id, $0.image.filter { $0 == 0 }.count) }
            .sorted { $0.1 < $1.1 } // fewest 0 digits
            .first!.0
        let ones = image.layers[layer].image.filter { $0 == 1 }.count
        let twos = image.layers[layer].image.filter { $0 == 2 }.count
        return ones * twos
    }
}

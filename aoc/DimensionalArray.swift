//
//  DimensionalArray.swift
//  aoc
//
//  Created by Paul Uhn on 12/11/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct TwoDimensionalArray<T> {
    let width: Int
    let height: Int
    private(set) var data: ContiguousArray<T>
    
    init(repeating value: T, width: Int, height: Int) {
        guard width > 0 && height > 0 else { fatalError() }
        self.width = width
        self.height = height
        data = ContiguousArray(repeating: value, count: width * height)
    }
    
    func get(_ x: Int, _ y: Int) -> T {
        return data[x * width + y]
    }
    
    mutating func set(_ x: Int, _ y: Int, to value: T) {
        data[x * width + y] = value
    }
}

extension TwoDimensionalArray where T: Equatable {
    func find(_ value: T) -> (Int, Int)? {
        guard let index = data.firstIndex(where: { $0 == value }) else {
            return nil
        }
        let x = index / width
        let y = index % width
        return (x, y)
    }
}

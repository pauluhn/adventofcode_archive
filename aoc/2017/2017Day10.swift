//
//  2017Day10.swift
//  aoc
//
//  Created by Paul Uhn on 11/8/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2017Day10 {
    
    static func Part1(_ count: Int, _ data: String) -> Int {
        let list = CircularList<Int>()
        for i in 0..<count {
            list.append(i)
        }
        
        var currentPosition = list.head!
        var skipSize = 0
        
        let inputs = data.split(separator: ",").compactMap { Int(String($0)) }
        
        for sublist in inputs {
            // get values for sublist
            var values = [Int]()
            for i in 0..<sublist {
                let value = list.get(currentPosition, offset: i).value
                values.append(value)
            }
            values.reverse()
            
            // set values back
            for i in 0..<sublist {
                list.get(currentPosition, offset: i).value = values[i]
            }
            
            // move sublist + skipSize
            currentPosition = list.get(currentPosition, offset: sublist + skipSize)

            skipSize += 1
        }
        
        let value1 = list.head!.value
        let value2 = list.get(list.head!, offset: 1).value
        
        return value1 * value2
    }
}

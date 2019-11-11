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
        let inputs = data.split(separator: ",").compactMap { Int(String($0)) }
        var currentPosition = list.head!
        var skipSize = 0
        
        let values = round(list, inputs, &currentPosition, &skipSize)
        return values[0] * values[1]
    }
    
    static func Part2(_ count: Int, _ data: String) -> String {
        assert("1,2,3".ascii == [49,44,50,44,51])
        
        let suffix = [17, 31, 73, 47, 23]
        assert("1,2,3".ascii + suffix == [49,44,50,44,51,17,31,73,47,23])
        
        let list = CircularList<Int>()
        for i in 0..<count {
            list.append(i)
        }
        let inputs = data.ascii + suffix
        var currentPosition = list.head!
        var skipSize = 0
        var values = [Int]()
        
        for _ in 0..<64 {
            values = round(list, inputs, &currentPosition, &skipSize)
        }

        assert(65 ^ 27 ^ 9 ^ 1 ^ 4 ^ 3 ^ 40 ^ 50 ^ 91 ^ 7 ^ 6 ^ 0 ^ 2 ^ 5 ^ 68 ^ 22 == 64)
        assert(values.count % 16 == 0)
        
        var hex = [Int]()
        for i in 0..<values.count / 16 {
            let initial = i * 16
            let range = values[initial + 1..<initial + 16]
            let value = range.reduce(values[initial], ^)
            hex.append(value)
        }
        let answer = hex.map { $0.hexString }.joined().lowercased()
        return answer
    }
    
    private static func round(_ list: CircularList<Int>, _ inputs: [Int], _ currentPosition: inout CircularList<Int>.CircularListNode<Int>, _ skipSize: inout Int) -> [Int] {
        
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
        
        var values = [list.head!.value]
        for i in 1..<list.count {
            let value = list.get(list.head!, offset: i).value
            values.append(value)
        }
        return values
    }
}

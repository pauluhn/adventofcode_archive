//
//  2018Day11.swift
//  aoc
//
//  Created by Paul Uhn on 12/11/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day11 {
    static func Part1(_ data: [Int], _ minSize: Int) -> [FuelCell] {
        let size = 300

        assert(power(for: FuelCell(3, 5, 8)) == 4)
        assert(power(for: FuelCell(122, 79, 57)) == -5)
        assert(power(for: FuelCell(217, 196, 39)) == 0)
        assert(power(for: FuelCell(101, 153, 71)) == 4)
        
        var maxFuelCells = [FuelCell]()
        for gridID in data {
            var grid = TwoDimensionalArray(repeating: 0, width: size, height: size)
            var maxPower = 0
            var maxPoint = Point(x: 0, y: 0)
            var xReady = false
            var yReady = false
            
            for x in 0..<size {
                if !xReady && x >= minSize - 1 { xReady = true }
                yReady = false
                
                for y in 0..<size {
                    if !yReady && y >= minSize - 1 { yReady = true }

                    let value = power(for: FuelCell(x + 1, y + 1, gridID))
                    grid.set(x, y, to: value)
                    
                    if xReady && yReady {
                        let point = Point(x: x - minSize + 1, y: y - minSize + 1)
                        let aPower = power(at: point, size: minSize, for: grid)
                        if aPower > maxPower {
                            maxPower = aPower
                            maxPoint = point
                        }
                    }
                }
            }
            maxFuelCells.append(FuelCell(maxPoint.x + 1, maxPoint.y + 1, maxPower)) // for minSize x minSize
        }
        return maxFuelCells
    }
    static func Part2(_ data: [Int], _ maxSize: Int) -> [FuelCell] {
        var answer = Part1(data, 1).map { ($0, 1) }
        
        for minSize in 2...maxSize {
            let part1 = Part1(data, minSize).map { ($0, minSize) }
            let someAnswer = answer
            for (i, a) in someAnswer.enumerated() {
                if part1[i].0.power > a.0.power {
                    answer[i] = part1[i]
                }
            }
        }
        return answer.map { $0.0.changingPower(to: $0.1) }
    }
}
private extension Y2018Day11 {
    static func power(for fuelCell: FuelCell) -> Int {
        let rackID = fuelCell.x + 10
        var power = rackID * fuelCell.y
        power += fuelCell.power // grid serial number
        power *= rackID
        power = power / 100 % 10
        power -= 5
        return power
    }
    static func power(at point: Point, size: Int, for grid: TwoDimensionalArray<Int>) -> Int {
        let maxX = point.x + size
        let maxY = point.y + size
        guard maxX <= grid.width && maxY <= grid.height else { fatalError() }
        
        var power = 0
        for x in point.x..<maxX {
            for y in point.y..<maxY {
                power += grid.get(x, y)
            }
        }
        return power
    }
}

//
//  2019Day7.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/19.
//  Copyright © 2019 Rightpoint. All rights reserved.
//

import Foundation

struct Y2019Day7 {
    typealias PSS = PhaseSettingSequence
    struct PhaseSettingSequence {
        private(set) var sequence = [Int]()
        var count: Int { return sequence.count }
        init?(_ s: [Int]) {
            guard s.count == Set(s).count else { return nil }
            sequence = s
        }
        subscript(index: Int) -> Int { return sequence[index] }
    }
    
    static func Part1(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var maxOutput = 0
        var maxPSS: PSS!
        
        for pss in allPSS(for: [0, 1, 2, 3, 4]) {
            let a = IntcodeComputer(program: program,
                                    inputs: [pss[0], 0])
            _ = a.run()
            
            let b = IntcodeComputer(program: program,
                                    inputs: [pss[1], a.outputs.last!])
            _ = b.run()
            
            let c = IntcodeComputer(program: program,
                                    inputs: [pss[2], b.outputs.last!])
            _ = c.run()

            let d = IntcodeComputer(program: program,
                                    inputs: [pss[3], c.outputs.last!])
            _ = d.run()

            let e = IntcodeComputer(program: program,
                                    inputs: [pss[4], d.outputs.last!])
            _ = e.run()
            
            let output = e.outputs.last!
            if output > maxOutput {
                maxOutput = output
                maxPSS = pss
            }
        }
        print("pss is", maxPSS.sequence)
        return maxOutput
    }

    static func Part2(_ data: String) -> Int {
        let program = data.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
        
        var maxOutput = 0
        var maxPSS: PSS!
        
        for pss in allPSS(for: [5, 6, 7, 8, 9]) {
            var a: IntcodeComputer!
            var b: IntcodeComputer!
            var c: IntcodeComputer!
            var d: IntcodeComputer!
            var e: IntcodeComputer!

            a = IntcodeComputer(program: program,
                                inputs: [pss[0]]) { b.appendInput($0) }
            b = IntcodeComputer(program: program,
                                inputs: [pss[1]]) { c.appendInput($0) }
            c = IntcodeComputer(program: program,
                                inputs: [pss[2]]) { d.appendInput($0) }
            d = IntcodeComputer(program: program,
                                inputs: [pss[3]]) { e.appendInput($0) }
            e = IntcodeComputer(program: program,
                                inputs: [pss[4]]) { a.appendInput($0) }
            
            // send 0 to `a` exactly once
            a.appendInput(0)
            
            var aa = false
            var bb = false
            var cc = false
            var dd = false
            var ee = false
            repeat {
                aa = a.tick()
                bb = b.tick()
                cc = c.tick()
                dd = d.tick()
                ee = e.tick()
            } while aa || bb || cc || dd || ee
            
            let output = e.outputs.last!
            if output > maxOutput {
                maxOutput = output
                maxPSS = pss
            }
        }
        print("pss is", maxPSS.sequence)
        return maxOutput
    }
}

private extension Y2019Day7 {
    static func allPSS(for sequence: [Int]) -> [PSS] { // all permutations
        var pss = sequence.compactMap { PSS([$0]) }
        while pss.first!.count < sequence.count {
            pss = pss.flatMap { $0.clone(sequence) }
        }
        return pss
    }
}

private extension Y2019Day7.PhaseSettingSequence {
    typealias PSS = Y2019Day7.PhaseSettingSequence
    func clone(_ sequence: [Int]) -> [PSS] {
        return sequence.compactMap { PSS(self.sequence + [$0]) }
    }
}

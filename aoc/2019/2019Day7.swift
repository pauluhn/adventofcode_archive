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
        
        for pss in allPSS {
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
}

private extension Y2019Day7 {
    static var initialPSS = [0, 1, 2, 3, 4]
    static var allPSS: [PSS] { // all permutations
        var pss = initialPSS.compactMap { PSS([$0]) }
        while pss.first!.count < initialPSS.count {
            pss = pss.flatMap { $0.clone(initialPSS) }
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

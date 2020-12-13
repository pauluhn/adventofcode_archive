//
//  ChineseRemainderTheorem.swift
//  aoc
//
//  Created by Paul U on 12/13/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

typealias CRT = ChineseRemainderTheorem
struct ChineseRemainderTheorem {
    
    /// 3 (mod 5) is written `Input(remainder: 3, mod 5)`
    struct Input {
        let remainder: Int
        let mod: Int
    }
    
    let inputs: [Input]
    init(inputs: [Input]) {
        self.inputs = inputs
    }
    init(inputs: [(Int, Int)]) {
        self.inputs = inputs.map { Input(remainder: $0.0, mod: $0.1) }
    }
    
    func compute() -> Int {
        let bi = inputs.map { $0.remainder }
        let mi = inputs.map { $0.mod }
        
        let N  = mi.reduce(1, *)
        let Ni = mi.map { N / $0 }
        
        let xi = zip(Ni, mi).map { computeXi(Ni: $0, mi: $1) }
        
        var biNixi = [Int]()
        for i in 0 ..< bi.count {
            biNixi += [bi[i] * Ni[i] * xi[i]]
        }
        let sum = biNixi.reduce(0, +)
        return sum % N
    }
    
    private func computeXi(Ni: Int, mi: Int) -> Int {
        var xi = 1
        while Ni * xi % mi != 1 {
            xi += 1
        }
        return xi
    }
}

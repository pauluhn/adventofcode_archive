//
//  Ascii.swift
//  aoc
//
//  Created by Paul Uhn on 1/11/20.
//  Copyright © 2020 Rightpoint. All rights reserved.
//

import Foundation

struct Ascii {
    let value: String
    let int: Int
    
    init(_ int: Int) {
        let uint8 = int < UInt8.max ? UInt8(int) : .max
        let unicode = UnicodeScalar(uint8)
        value = String(unicode)
        self.int = int
    }

    init(_ uint8: UInt8) {
        let unicode = UnicodeScalar(uint8)
        value = String(unicode)
        int = Int(uint8)
    }
}

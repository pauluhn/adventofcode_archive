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
    
    init(_ int: Int) {
        let uint8 = UInt8(int)
        let unicode = UnicodeScalar(uint8)
        value = String(unicode)
    }
}

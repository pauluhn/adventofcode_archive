//
//  Acre.swift
//  aoc
//
//  Created by Paul Uhn on 12/18/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Acre {
    enum State {
        case open
        case trees
        case lumberyard
    }
    private(set) var current: State
    private var inputs = [State]()
    
    init?(_ data: Character) {
        switch data {
        case .open: current = .open
        case .trees: current = .trees
        case .lumberyard: current = .lumberyard
        default: return nil
        }
    }
    
    func reset() {
        inputs = []
    }
    
    func add(input: State) {
        inputs.append(input)
    }
    
    func compute() {
        let count = countInputs()
        switch current {
        case .open where count.trees > 2:
            current = .trees
        case .trees where count.lumberyard > 2:
            current = .lumberyard
        case .lumberyard where count.trees > 0 && count.lumberyard > 0:
            break
        case .lumberyard:
            current = .open
        default:
            break
        }
    }
}
extension Acre: CustomStringConvertible {
    var description: String {
        return String(char)
    }
    private var char: Character {
        switch current {
        case .open: return .open
        case .trees: return .trees
        case .lumberyard: return .lumberyard
        }
    }
}
private extension Acre {
    func countInputs() -> (open: Int, trees: Int, lumberyard: Int) {
        var open = 0
        var trees = 0
        var lumberyard = 0
        
        for input in inputs {
            switch input {
            case .open: open += 1
            case .trees: trees += 1
            case .lumberyard: lumberyard += 1
            }
        }
        return (open, trees, lumberyard)
    }
}
private extension Character {
    static let open: Character = "."
    static let trees: Character = "|"
    static let lumberyard: Character = "#"
}

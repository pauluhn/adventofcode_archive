//
//  BinaryTree.swift
//  aoc
//
//  Created by Paul Uhn on 12/12/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class BinaryTree<T: Equatable> {
    let value: T
    var left: BinaryTree?
    var right: BinaryTree?
    
    init(_ value: T) {
        self.value = value
    }
    
    func search(for query: [T]) -> T? {
        return search(for: query, index: 0)
    }
    
    private func search(for query: [T], index: Int) -> T? {
        guard index < query.count else { return value }
        guard query[index] == value else { return nil }
        
        if let l = left?.search(for: query, index: index + 1) {
            return l
        }
        if let r = right?.search(for: query, index: index + 1) {
            return r
        }
        return nil
    }
}

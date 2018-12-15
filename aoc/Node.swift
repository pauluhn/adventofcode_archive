//
//  Node.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Node<T: Hashable> {
    var value: T
    private(set) var children = [Node]()
    private(set) var parents = [Node]()
    
    init(_ value: T) {
        self.value = value
        children = []
        parents = []
    }
    
    func add(child: Node) {
        children.append(child)
    }
    
    func add(parent: Node) {
        parents.append(parent)
    }
}
extension Node: Hashable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value
    }
    var hashValue: Int {
        return value.hashValue
    }
}
extension Node: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        let parents = self.parents.map { $0.value.description }.reduce("", +)
        let children = self.children.map { $0.value.description }.reduce("", +)
        return "\(value.description):\(children):(\(parents))"
    }
}

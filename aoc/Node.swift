//
//  Node.swift
//  aoc
//
//  Created by Paul Uhn on 12/7/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Node {
    let id: String
    private(set) var children = [Node]()
    private(set) var parents = [Node]()
    
    init(id: String) {
        self.id = id
        self.children = []
        self.parents = []
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
        return lhs.id == rhs.id
    }
    var hashValue: Int {
        return id.hashValue
    }
}
extension Node: CustomStringConvertible {
    var description: String {
        let parents = self.parents.map { $0.id }.reduce("", +)
        let children = self.children.map { $0.id }.reduce("", +)
        return "\(id):\(children):(\(parents))"
    }
}
extension Collection where Element == Node {
    func find(id: String) -> Node? {
        return first { $0.id == id }
    }
}

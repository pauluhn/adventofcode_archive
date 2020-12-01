//
//  GraphCap.swift
//  aoc
//
//  Created by Paul Uhn on 12/27/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class GraphCap<T: Hashable> {
    struct GraphNode<T: Hashable>: Hashable {
        let value: T
        let index: Int
        init(_ v: T, _ i: Int) { value = v; index = i }
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
        static func == (lhs: GraphNode, rhs: GraphNode) -> Bool {
            return lhs.value == rhs.value
        }
    }
    typealias Node = GraphNode<T>
    
    struct GraphLink {
        let from: Node
        let to: Node
        let weight: Double?
    }
    
    private class GraphLinkList {
        let node: Node
        var edges = [GraphLink]()
        init(_ n: Node) { node = n }
        func add(_ e: GraphLink) { edges.append(e) }
    }
    private var list: ContiguousArray<GraphLinkList>
    
    private(set) var count: Int
    private(set) var p: Int
    private var isReady: Bool { return p == count }

    init(repeating value: T, capacity: Int) {
        var list = [GraphLinkList]()
        for i in 0..<capacity {
            list.append(GraphLinkList(Node(value, i)))
        }
        self.list = ContiguousArray(list)
        count = capacity
        p = 0
    }
    
    func append(_ value: T) -> Node {
        guard !isReady else { fatalError() }
        let node = Node(value, p)
        list[p] = GraphLinkList(node)
        p += 1
        return node
    }

    func get(index: Int) -> Node? {
        guard index >= 0, index < p else { return nil }
        return list[index].node
    }
    
    func filter(where predicate: (T) -> Bool) -> [Node] {
        var match = [Node]()
        for i in (0..<p).reversed() {
            if predicate(list[i].node.value) {
                match.append(list[i].node)
            }
        }
        return match
    }
    
    func link(_ from: Node, to: Node, weight: Double? = nil) {
        list[from.index].add(GraphLink(from: from, to: to, weight: weight))
    }
    
    func weight(_ from: Node, to: Node) -> Double? {
        return list[from.index].edges.first { $0.to == to }?.weight
    }

    func links(_ from: Node) -> [GraphLink] {
        return list[from.index].edges
    }
    
    func data<U>(initial: U) -> [Node: U] {
        guard isReady else { fatalError() }
        return list
            .map { $0.node }
            .reduce(into: [Node: U]()) { $0[$1] = initial }
    }
}
extension GraphCap.GraphNode: CustomStringConvertible {
    var description: String {
        return "\(value)"
    }
}
extension GraphCap.GraphLink: CustomStringConvertible {
    var description: String {
        return "\(to.value)\(weight != nil ? ":\(weight!)" : "")"
    }
}
extension GraphCap: CustomStringConvertible {
    var description: String {
        return list.reduce("") { $0 + "\($1.node) -> \($1.edges)\n" }
    }
}

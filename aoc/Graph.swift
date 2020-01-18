//
//  Graph.swift
//  aoc
//
//  Created by Paul Uhn on 12/20/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Graph<T: Hashable> {
    struct GraphNode<T: Hashable>: Hashable {
        let value: T
        let index: Int
        init(_ v: T, _ i: Int) { value = v; index = i }
        var hashValue: Int { return value.hashValue }
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
    private var list = [GraphLinkList]()
    
    var nodes: [Node] {
        return list.map { $0.node }
    }
    var links: [GraphLink] {
        return list.flatMap { $0.edges }
    }
    
    func create(_ value: T) -> Node {
        if let matching = list.first(where: { $0.node.value == value }) {
            return matching.node
        }
        let node = Node(value, list.count)
        list.append(GraphLinkList(node))
        return node
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
    
    func unlink(_ from: Node, to: Node) {
        guard let index = list[from.index].edges.firstIndex(where: { $0.to == to }) else { return }
        list[from.index].edges.remove(at: index)
    }
}
extension Graph.GraphNode: CustomStringConvertible {
    var description: String {
        return "\(value)"
    }
}
extension Graph.GraphLink: CustomStringConvertible {
    var description: String {
        return "\(to.value)\(weight != nil ? ":\(weight!)" : "")"
    }
}
extension Graph: CustomStringConvertible {
    var description: String {
        return list.reduce("") { $0 + "\($1.node) -> \($1.edges)\n" }
    }
}
extension Graph where T == Point { // for a_star
    func data(initial: Int) -> [Point: Int] {
        return nodes.reduce(into: [Point: Int]()) {
            $0[$1.value] = initial
        }
    }
}

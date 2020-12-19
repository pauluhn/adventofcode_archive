//
//  2020Day19.swift
//  aoc
//
//  Created by Paul U on 12/19/20.
//  Copyright © 2020 Mojio. All rights reserved.
//

import Foundation

struct Y2020Day19 {
    
    enum NodeType: CustomStringConvertible {
        case tree([Node])
        case orTree([Node], [Node])
        case leaf(String)
        
        static var emptyTree: NodeType { .tree([]) }
        var description: String {
            switch self {
            case let .tree(n):
                return "tree: \(n.map({ $0.id }).joined(separator: ","))"
            case let .orTree(lhs, rhs):
                let l = lhs.map({ $0.id }).joined(separator: ",")
                let r = rhs.map({ $0.id }).joined(separator: ",")
                return "or-tree: \(l) || \(r)"
            case let .leaf(v):
                return "leaf: \(v)"
            }
        }
    }
    
    class Node: CustomStringConvertible, CustomDebugStringConvertible {
        let id: String
        var type: NodeType
        init?(id: String, type: NodeType = .emptyTree) {
            guard !id.isEmpty && id != "|" else { return nil }
            self.id = id
            self.type = type
        }
        var description: String {
            switch type {
            case let .tree(n):
                return n.reduce("") { "\($0)\($1)" }
            case let .orTree(lhs, rhs):
                let l = lhs.reduce("") { "\($0)\($1)" }
                let r = rhs.reduce("") { "\($0)\($1)" }
                return "(\(l)|\(r))"
            case let .leaf(v):
                return v
            }
        }
        var debugDescription: String {
            return "node-\(id): \(type)"
        }
    }

    class NodeGraph: CustomDebugStringConvertible {
        private(set) var nodes = [Node]()
        
        @discardableResult
        func createOrUpdate(id: String, type: NodeType = .emptyTree) -> Node {
            guard let node = self.node(id: id) else {
                // create
                let node = Node(id: id, type: type)! //// check??
                nodes.append(node)
                return node
            }
            // update
            switch node.type {
            case .tree(let n) where n.isEmpty: node.type = type
            default: break
            }
            return node
        }
        func node(id: String) -> Node? {
            return nodes.first { $0.id == id }
        }
        var debugDescription: String {
            return nodes.reduce("") { "\($0)\($1.debugDescription)\n" }
        }
    }
    
    struct Rule {
        let id: String
        let type: NodeType
        
        init?(_ data: String) {
            let regex = try! NSRegularExpression(pattern: "^([0-9]+): (\"[a-b]+\"|[0-9\\| ]+)$")
            guard let match = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return nil }
            id = data.match(match, at: 1)
            let rule = data.match(match, at: 2)
            if rule.hasPrefix("\"") {
                // leaf
                let value = rule.dropFirst().dropLast().str
                type = .leaf(value)
            } else if let index = rule.firstIndex(where: { $0 == "|" }) {
                // or tree
                let lhs = rule.prefix(upTo: index)
                    .components(separatedBy: .whitespaces)
                    .compactMap { Node(id: $0) }
                let rhs = rule.suffix(from: index)
                    .components(separatedBy: .whitespaces)
                    .compactMap { Node(id: $0) }
                type = .orTree(lhs, rhs)
            } else {
                // tree
                let nodes = rule
                    .components(separatedBy: .whitespaces)
                    .compactMap { Node(id: $0) }
                type = .tree(nodes)
            }
        }
    }
    
    struct MessageRule {
        let regex: NSRegularExpression
        init(_ data: String) {
            regex = try! NSRegularExpression(pattern: "^\(data)$")
        }
        func isValid(message data: String) -> Bool {
            guard let _ = regex.firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) else { return false }
            return true
        }
    }

    static func Part1(_ data: String) -> Int {
        let data = data.components(separatedBy: "\n\n")
        guard data.count == 2 else { fatalError() }
        // rules
        let rules = data[0]
            .components(separatedBy: .newlines)
            .compactMap(Rule.init)
        // graph
        let graph = NodeGraph()
        for rule in rules {
            switch rule.type {
            case let .tree(nodes):
                let children = nodes.map { graph.createOrUpdate(id: $0.id) }
                graph.createOrUpdate(id: rule.id, type: .tree(children))
            case let .orTree(lhs, rhs):
                let l = lhs.map { graph.createOrUpdate(id: $0.id) }
                let r = rhs.map { graph.createOrUpdate(id: $0.id) }
                graph.createOrUpdate(id: rule.id, type: .orTree(l, r))
            case .leaf:
                graph.createOrUpdate(id: rule.id, type: rule.type)
            }
        }
        let root = graph.node(id: "0")!
        let rule = MessageRule(root.description)
        // messages
        return data[1]
            .components(separatedBy: .newlines)
            .filter { rule.isValid(message: $0) }
            .count
    }
}

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

    private static func parse(_ data: String) -> (NodeGraph, [String]) {
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
        // messages
        let messages = data[1]
            .components(separatedBy: .newlines)
        return (graph, messages)
    }
    
    static func Part1(_ data: String) -> Int {
        let (graph, messages) = parse(data)
        let root = graph.node(id: "0")!
        let rule = MessageRule(root.description)
        return messages
            .filter { rule.isValid(message: $0) }
            .count
    }
    
    private static var loop = false
    static func Part2(_ data: String, with loop: Bool = false) -> Int {
        self.loop = loop
        let (graph, messages) = parse(data)
        let root = graph.node(id: "0")!
        
        var count = 0
        for var message in messages {
            switch root.type {
            case .tree: count += tree(root, &message) && message.isEmpty ? 1 : 0
            case .orTree: count += orTree(root, &message) && message.isEmpty ? 1 : 0
            case .leaf: count += leaf(root, &message) && message.isEmpty ? 1 : 0
            }
        }
        return count
    }
    private static var eightCount = 0
    
    private static func tree(_ node: Node, _ message: inout String) -> Bool {
        if loop {
            if node.id == "8" { return eight(node, &message) }
            if node.id == "11" { return eleven(node, &message) }
        }

        var copy = message
        switch node.type {
        case .tree(let nodes):
            var isValid = true
            for n in nodes {
                switch n.type {
                case .tree: isValid = tree(n, &copy)
                case .orTree: isValid = orTree(n, &copy)
                case .leaf: isValid = leaf(n, &copy)
                }
                if !isValid { return false }
            }
            message = copy
            return true
        default: fatalError()
        }
    }

    private static func eight(_ node: Node, _ message: inout String) -> Bool {
        var copy = message
        var count = 0
        switch node.type {
        case .tree(let nodes):
            guard nodes.count == 1 else { fatalError() }
            var isValid = true
            switch nodes.first!.type {
            case .tree: isValid = tree(nodes.first!, &copy)
            case .orTree: isValid = orTree(nodes.first!, &copy)
            case .leaf: isValid = leaf(nodes.first!, &copy)
            }
            if !isValid { return false }
            message = copy
            count += 1
            // n-loops
            while isValid {
                switch nodes.first!.type {
                case .tree: isValid = tree(nodes.first!, &copy)
                case .orTree: isValid = orTree(nodes.first!, &copy)
                case .leaf: isValid = leaf(nodes.first!, &copy)
                }
                if !isValid { break }
                if isValid {
                    message = copy
                    count += 1
                }
            }
            eightCount = count
            return true
        default: fatalError()
        }
    }
    
    private static func eleven(_ node: Node, _ message: inout String) -> Bool {
        guard eightCount > 1 else { return false }
        
        var copy = message
        var count = 0
        switch node.type {
        case .tree(let nodes):
            guard nodes.count == 2 else { fatalError() }
            // rhs
            var isValid = true
            switch nodes.last!.type {
            case .tree: isValid = tree(nodes.last!, &copy)
            case .orTree: isValid = orTree(nodes.last!, &copy)
            case .leaf: isValid = leaf(nodes.last!, &copy)
            }
            if !isValid { return false }
            message = copy
            count += 1
            // n-loops
            while isValid {
                switch nodes.last!.type {
                case .tree: isValid = tree(nodes.last!, &copy)
                case .orTree: isValid = orTree(nodes.last!, &copy)
                case .leaf: isValid = leaf(nodes.last!, &copy)
                }
                if !isValid { break }
                if isValid {
                    message = copy
                    count += 1
                }
            }
            return count < eightCount
        default: fatalError()
        }
    }

    private static func orTree(_ node: Node, _ message: inout String) -> Bool {
        var copy = message
        switch node.type {
        case let .orTree(lhs, rhs):
            // lhs
            var isValid = true
            for n in lhs {
                switch n.type {
                case .tree: isValid = tree(n, &copy)
                case .orTree: isValid = orTree(n, &copy)
                case .leaf: isValid = leaf(n, &copy)
                }
                if !isValid { break }
            }
            if isValid {
                message = copy
                return true
            }
            // rhs
            copy = message
            for n in rhs {
                switch n.type {
                case .tree: isValid = tree(n, &copy)
                case .orTree: isValid = orTree(n, &copy)
                case .leaf: isValid = leaf(n, &copy)
                }
                if !isValid { break }
            }
            if isValid {
                message = copy
                return true
            }
            return false
        default: fatalError()
        }
    }

    private static func leaf(_ node: Node, _ message: inout String) -> Bool {
        guard !message.isEmpty else { return false }
        let first = message.removeFirst()
        switch node.type {
        case .leaf(let v): return v == first.str
        default: fatalError()
        }
    }
}

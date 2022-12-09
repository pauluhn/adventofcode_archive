//
//  2022Day7.swift
//  aoc
//
//  Created by Paul U on 12/7/22.
//  Copyright © 2022 Mojio. All rights reserved.
//

import Foundation

struct Y2022Day7 {
    typealias Table = [String: Int]

    enum Filesystem: Hashable {
        case dir(name: String)
        case file(name: String, size: Int)
    }

    static func Part1(_ data: [String]) -> Int {
        let root = parse(data)
        var table = Table()

        recursive(node: root, table: &table)
        let answer = table.values
            .filter { $0 <= 100000 }
            .reduce(0, +)
        return answer
    }

    static func Part2(_ data: [String]) -> Int {
        let root = parse(data)
        var table = Table()

        let total = 70000000
        let used = recursive(node: root, table: &table)
        let free = 30000000
        let find = free - (total - used)

        let answer = table.values
            .filter { $0 >= find }
            .sorted()
            .first!
        return answer
    }

    @discardableResult
    private static func recursive(node: Node<Filesystem>, table: inout Table) -> Int {
        assert(node.value.isDir)
        let children = node.children
        let dirs = children
            .filter { $0.value.isDir }
            .map { recursive(node: $0, table: &table) }
        let files = children
            .filter { !$0.value.isDir }
            .map { $0.value.size }
        let size = (dirs + files).reduce(0, +)
        table[node.fullName] = size
        return size
    }
}

private extension Y2022Day7.Filesystem {
    var isDir: Bool {
        switch self {
        case .dir: return true
        case .file: return false
        }
    }
    var name: String {
        switch self {
        case .dir(let name): return name
        case .file(let name, _): return name
        }
    }
    var size: Int {
        switch self {
        case .dir: fatalError()
        case .file(_, let size): return size
        }
    }
}

private extension Y2022Day7 {
    enum State {
        case command
        case filesystem
    }
    enum Command {
        case cd(dir: String)
        case ls
    }

    static func parse(_ data: [String]) -> Node<Filesystem> {
        var root: Node<Filesystem>?
        var dir: Node<Filesystem>?

        var state = State.command
        for line in data {
            switch state {

            case .filesystem:
                if let name = parseDIR(line) {
                    dir!.createChild(.dir(name: name))
                } else if let (name, size) = parseFILE(line) {
                    dir!.createChild(.file(name: name, size: size))
                } else {
                    state = .command
                    fallthrough
                }

            case .command:
                if let cd = parseCD(line) {
                    handleCD(cd, &root, &dir)
                } else if line == "$ ls" {
                    state = .filesystem
                }
            }
        }
        return root!
    }

    private static func handleCD(_ cd: String, _ root: inout Node<Filesystem>?, _ dir: inout Node<Filesystem>?) {
        switch cd {
        case "/":
            root = Node(Filesystem.dir(name: "/"))
            dir = root
        case "..":
            let parent = dir!.parents
            assert(parent.count == 1)
            dir = parent.first!
        default:
            let child = dir!.children.filter { $0.value.name == cd }
            if child.count == 1 {
                assert(child.first!.value.isDir)
                dir = child.first!
            } else {
                assert(child.isEmpty)
                let child = dir!.createChild(.dir(name: cd))
                dir = child
            }
        }
    }

    private static func parseCD(_ data: String) -> String? {
        let regex = /^\$ cd ([\/.a-z]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { return nil }

        let dir = results.1.str
        return dir
    }
    private static func parseDIR(_ data: String) -> String? {
        let regex = /^dir ([a-z]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { return nil }

        let name = results.1.str
        return name
    }
    private static func parseFILE(_ data: String) -> (String, Int)? {
        let regex = /^([0-9]+) ([a-z\.]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { return nil }

        let size = results.1.int
        let name = results.2.str
        return (name, size)
    }
}

private extension Node where T == Y2022Day7.Filesystem {
    @discardableResult
    func createChild(_ value: T) -> Node {
        let child = Node(value)
        add(child: child)
        child.add(parent: self)
        return child
    }

    var fullName: String {
        var name = [value.name]
        var node = self
        while true {
            if node.parents.count == 1 {
                node = node.parents.first!
                name.append(node.value.name)
            } else {
                break
            }
        }
        return name.reversed().joined(separator: "/")
    }
}

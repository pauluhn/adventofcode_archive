//
//  Octree.swift
//  aoc
//
//  Created by Paul Uhn on 12/28/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

class Octree {
    class OctreeNode {
        let box: Box
        lazy var children: Children = { Children(parent: self) }()
        init(box: Box) { self.box = box }
        
        struct Children: Sequence {
            let frontTopLeft: OctreeNode
            let frontTopRight: OctreeNode
            let frontBottomLeft: OctreeNode
            let frontBottomRight: OctreeNode
            let backTopLeft: OctreeNode
            let backTopRight: OctreeNode
            let backBottomLeft: OctreeNode
            let backBottomRight: OctreeNode
            init(parent: OctreeNode) {
                frontTopLeft = OctreeNode(box: parent.box.frontTopLeft)
                frontTopRight = OctreeNode(box: parent.box.frontTopRight)
                frontBottomLeft = OctreeNode(box: parent.box.frontBottomLeft)
                frontBottomRight = OctreeNode(box: parent.box.frontBottomRight)
                backTopLeft = OctreeNode(box: parent.box.backTopLeft)
                backTopRight = OctreeNode(box: parent.box.backTopRight)
                backBottomLeft = OctreeNode(box: parent.box.backBottomLeft)
                backBottomRight = OctreeNode(box: parent.box.backBottomRight)
            }
            struct ChildrenIterator: IteratorProtocol {
                private(set) var index = 0
                let children: Children
                init(_ children: Children) { self.children = children }
                mutating func next() -> OctreeNode? {
                    defer { index += 1 }
                    switch index {
                    case 0: return children.frontTopLeft
                    case 1: return children.frontTopRight
                    case 2: return children.frontBottomLeft
                    case 3: return children.frontBottomRight
                    case 4: return children.backTopLeft
                    case 5: return children.backTopRight
                    case 6: return children.backBottomLeft
                    case 7: return children.backBottomRight
                    default: return nil
                    }
                }
            }
            func makeIterator() -> ChildrenIterator {
                return ChildrenIterator(self)
            }
        }
        func nodeDescription(_ nodeSequenceIndex: Int) -> String {
            switch nodeSequenceIndex {
            case 0: return "frontTopLeft"
            case 1: return "frontTopRight"
            case 2: return "frontBottomLeft"
            case 3: return "frontBottomRight"
            case 4: return "backTopLeft"
            case 5: return "backTopRight"
            case 6: return "backBottomLeft"
            case 7: return "backBottomRight"
            default: fatalError()
            }
        }
    }
    struct Box {
        var min: Point3D
        var max: Point3D
        
        func contains(_ point: Point3D) -> Bool {
            return min.x <= point.x && point.x <= max.x &&
                min.y <= point.y && point.y <= max.y &&
                min.z <= point.z && point.z <= max.z
        }
    }
    
    var root: OctreeNode
    init(bounds: Box) { root = OctreeNode(box: bounds) }
}
extension Octree.Box {
    typealias Box = Octree.Box
    
    var size: Point3D { return max - min }
    var half: Point3D { return size / 2 }
}
private extension Octree.Box {
    var frontTopLeft: Box {
        let min = self.min + Point3D(x: 0, y: half.y, z: half.z)
        let max = self.max - Point3D(x: half.x, y: 0, z: 0)
        return Box(min: min, max: max)
    }
    var frontTopRight: Box {
        let min = self.min + Point3D(x: half.x, y: half.y, z: half.z)
        let max = self.max
        return Box(min: min, max: max)
    }
    var frontBottomLeft: Box {
        let min = self.min + Point3D(x: 0, y: 0, z: half.z)
        let max = self.max - Point3D(x: half.x, y: half.y, z: 0)
        return Box(min: min, max: max)
    }
    var frontBottomRight: Box {
        let min = self.min + Point3D(x: half.x, y: 0, z: half.z)
        let max = self.max - Point3D(x: 0, y: half.y, z: 0)
        return Box(min: min, max: max)
    }
    var backTopLeft: Box {
        let min = self.min + Point3D(x: 0, y: half.y, z: 0)
        let max = self.max - Point3D(x: half.x, y: 0, z: half.z)
        return Box(min: min, max: max)
    }
    var backTopRight: Box {
        let min = self.min + Point3D(x: half.x, y: half.y, z: 0)
        let max = self.max - Point3D(x: 0, y: 0, z: half.z)
        return Box(min: min, max: max)
    }
    var backBottomLeft: Box {
        let min = self.min
        let max = self.max - Point3D(x: half.x, y: half.y, z: half.z)
        return Box(min: min, max: max)
    }
    var backBottomRight: Box {
        let min = self.min + Point3D(x: half.x, y: 0, z: 0)
        let max = self.max - Point3D(x: 0, y: half.y, z: half.z)
        return Box(min: min, max: max)
    }
}
extension Octree.Box: CustomStringConvertible {
    var description: String {
        return "Box min:\(min) max:\(max)"
    }
}
extension Octree.OctreeNode: CustomStringConvertible {
    var description: String {
        return "Node with \(box)"
    }
}

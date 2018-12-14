//
//  2018Day13.swift
//  aoc
//
//  Created by Paul Uhn on 12/13/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day13 {
    static func Part1(_ data: [String], _ crashNumber: Int) -> Point {
        var track = data.map { $0.map { $0 }}
        let carts = getCarts(track)
        remove(carts, from: &track)
        
        var crashes = [Point]()
        while crashes.count < crashNumber {
            let cartSorter: (Cart, Cart) -> Bool = { (cart1, cart2) in
                if cart1.position.y == cart2.position.y {
                    return cart1.position.x < cart2.position.x
                }
                return cart1.position.y < cart2.position.y
            }
            for cart in carts.sorted(by: cartSorter) {
                // check for crash
                let point = cart.previewMove()
                let crashOccurred = carts.first(where: { $0.position == point }) != nil
                if crashOccurred {
                    crashes.append(point)
                }
                
                // move cart
                cart.position = point
                
                // next direction
                var direction = cart.direction
                if !crashOccurred {
                    let piece = track[point.y][point.x]

                    if piece.isCurve {
                        direction = cart.turn(piece)
                        
                    } else if piece.isIntersection {
                        direction = cart.OTID()
                    }
                }
                
                // update cart
                cart.direction = direction
                
                // update track for display
//                var display = track
//                put(carts, on: &display)
//                printTrack(display)
            }
        }
        return crashes.last!
    }
    static func Part2(_ data: [String], _ remainingCarts: Int) -> Point {
        var track = data.map { $0.map { $0 }}
        var carts = getCarts(track)
        remove(carts, from: &track)
        
        while carts.count > remainingCarts {
            let cartSorter: (Cart, Cart) -> Bool = { (cart1, cart2) in
                if cart1.position.y == cart2.position.y {
                    return cart1.position.x < cart2.position.x
                }
                return cart1.position.y < cart2.position.y
            }
            for cart in carts.sorted(by: cartSorter) {
                // check for crash
                let point = cart.previewMove()
                if let crash = carts.first(where: { $0.position == point }) {
                    // remove carts
                    carts.removeAll { $0.position == crash.position || $0.position == cart.position }
                    continue
                }
                
                // move cart
                cart.position = point
                
                // next direction
                var direction = cart.direction
                let piece = track[point.y][point.x]
                
                if piece.isCurve {
                    direction = cart.turn(piece)
                    
                } else if piece.isIntersection {
                    direction = cart.OTID()
                }
                
                // update cart
                cart.direction = direction
                
                // update track for display
//                var display = track
//                put(carts, on: &display)
//                printTrack(display)
            }
        }
        return carts.first!.position
    }}
private extension Y2018Day13 {
    static func getCarts(_ track: [[Character]]) -> [Cart] {
        var carts = [Cart]()
        for (y, array) in track.enumerated() {
            for (x, char) in array.enumerated() where char.isCart {
                carts.append(Cart(x, y, char.cartDirection))
            }
        }
        return carts
    }
    static func remove(_ carts: [Cart], from track: inout [[Character]]) {
        for cart in carts {
            track[cart.position.y][cart.position.x] = cart.direction.trackCharacter
        }
    }
    static func put(_ carts: [Cart], on track: inout [[Character]]) {
        for cart in carts {
            track[cart.position.y][cart.position.x] = cart.cartCharacter
        }
    }
    static func printTrack(_ track: [[Character]]) {
        let display = track.reduce("") { $0 + $1.reduce("") { $0 + String($1) } + "\n" }
        print(display)
    }
}
private extension Character {
    var isCart: Bool {
        switch self {
        case "^", "v", "<", ">": return true
        default: return false
        }
    }
    var cartDirection: Direction {
        switch self {
        case "^": return .up
        case "v": return .down
        case "<": return .left
        case ">": return .right
        default: return .none
        }
    }
    var isCurve: Bool {
        switch self {
        case "/", "\\": return true
        default: return false
        }
    }
    var isIntersection: Bool {
        switch self {
        case "+": return true
        default: return false
        }
    }
}
private extension Cart {
    var cartCharacter: Character {
        switch direction {
        case .up: return "^"
        case .down: return "v"
        case .left: return "<"
        case .right: return ">"
        case .none: return "X"
        }
    }
    func previewMove() -> Point {
        switch direction {
        case .up: return Point(x: position.x, y: position.y - 1)
        case .down: return Point(x: position.x, y: position.y + 1)
        case .left: return Point(x: position.x - 1, y: position.y)
        case .right: return Point(x: position.x + 1, y: position.y)
        case .none: return position
        }
    }
    func turn(_ curve: Character) -> Direction {
        switch (direction, curve) {
        case (.up, "/"): return .right
        case (.up, "\\"): return .left
        case (.down, "/"): return .left
        case (.down, "\\"): return .right
        case (.left, "/"): return .down
        case (.left, "\\"): return .up
        case (.right, "/"): return .up
        case (.right, "\\"): return .down
        default: return direction
        }
    }
}
private extension Direction {
    var trackCharacter: Character {
        switch self {
        case .up, .down: return "|"
        case .left, .right: return "-"
        case .none: return " "
        }
    }
}

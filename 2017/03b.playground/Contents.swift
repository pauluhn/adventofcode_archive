import UIKit

enum Direction {
    case right, up, left, down
    
    func next() -> Direction {
        switch self {
        case .right: return .up
        case .up: return .left
        case .left: return .down
        case .down: return .right
        }
    }
}
struct Square: Hashable {
    var value: Int
    let x: Int
    let y: Int
    static func == (lhs: Square, rhs: Square) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    var hashValue: Int { return x ^ y }
    
    func move(direction: Direction) -> Square {
        switch direction {
        case .right: return Square(value: value, x: x + 1, y: y)
        case .up: return Square(value: value, x: x, y: y + 1)
        case .left: return Square(value: value, x: x - 1, y: y)
        case .down: return Square(value: value, x: x, y: y - 1)
        }
    }
}
extension Set where Element == Square {
    func totalNeighborValues(for square: Square) -> Int {
        let ul = Square(value: 0, x: square.x - 1, y: square.y + 1)
        let u = Square(value: 0, x: square.x, y: square.y + 1)
        let ur = Square(value: 0, x: square.x + 1, y: square.y + 1)
        let l = Square(value: 0, x: square.x - 1, y: square.y)
        let r = Square(value: 0, x: square.x + 1, y: square.y)
        let ll = Square(value: 0, x: square.x - 1, y: square.y - 1)
        let d = Square(value: 0, x: square.x, y: square.y - 1)
        let lr = Square(value: 0, x: square.x + 1, y: square.y - 1)
        return self
            .intersection([ul, u, ur, l, r, ll, d, lr])
            .reduce(0) { (result, square) -> Int in
                return result + square.value
        }
    }
}
var value = 1
var square = Square(value: value, x: 0, y: 0)
var set: Set<Square> = [square]
var direction = Direction.right

let input = 368078

while value < input {
    square = square.move(direction: direction)
    value = set.totalNeighborValues(for: square)
    square.value = value
    set.insert(square)

    // test next direction
    let next = direction.next()
    let nextSquare = square.move(direction: next)
    direction = set.contains(nextSquare) ? direction : next
}
print(value)

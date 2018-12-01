import UIKit

enum Direction {
    case right, up, left, down

    private static var value = 0
    static func steps(with direction: Direction) -> Int {
        return direction == .up ? value + 1 : value
    }
    func valueWithSideEffect() -> Int {
        switch self {
        case .right, .left: Direction.value += 1
        case .up, .down: break
        }
        return Direction.value
    }
    func next() -> Direction {
        switch self {
        case .right: return .up
        case .up: return .left
        case .left: return .down
        case .down: return .right
        }
    }
}
var direction = Direction.down
var square = 1
var prevSq = 0

let input = 368078
while square < input {
    direction = direction.next()
    prevSq = square
    square += direction.valueWithSideEffect()
    print(square)
}

let forward = square - input
let backward = input - prevSq
let isForward = forward < backward

let steps = Direction.steps(with: direction)
let diff = isForward ? forward : backward

let answer = (isForward ? steps : steps - 1) - diff


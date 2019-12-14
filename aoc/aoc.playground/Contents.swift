import UIKit


func offset(_ origin: Point, _ destination: Point) -> Point {
    guard origin != destination else { return .zero }
    let diff = destination - origin
    if diff.x == 0 {
        return Point(x: 0, y: diff.y / abs(diff.y))
    } else if diff.y == 0 {
        return Point(x: diff.x / abs(diff.x), y: 0)
    } else {
        return diff / abs(GCD(diff.x, diff.y))
    }
}
func angle(_ origin: Point, _ destination: Point) -> Double {
    let diff = offset(origin, destination)
    switch (diff.x, diff.y) {
    case (0, let y) where y > 0: return 90 // north
    case (0, let y) where y < 0: return 270 // south
    case (let x, 0) where x > 0: return 0 // east
    case (let x, 0) where x < 0: return 180 // west
    default: break
    }
    let radians = atan2(Double(diff.y), Double(diff.x))
    let degrees = radians * 180.0 / .pi
    return degrees > 0.0 ? degrees : 360 + degrees
}
let origin = Point.zero

//angle(origin, Point(x: 0, y: 1))
//angle(origin, Point(x: 1, y: 1))
angle(origin, Point(x: 1, y: -1))
//angle(origin, Point(x: -1, y: 1))
//angle(origin, Point(x: -1, y: -1))

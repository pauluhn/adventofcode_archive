import UIKit

func GCD(_ m: Int, _ n: Int) -> Int {
    var a = 0
    var b = max(m, n)
    var r = min(m, n)
    
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

GCD(2, 2)
GCD(1, 2)
GCD(2, 1)
GCD(3, 2)
GCD(0, 2)
GCD(-2, -4)
GCD(2, -4)
GCD(-2, 4)




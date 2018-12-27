import UIKit

//For example, if a defending group contains 10 units with 10 hit points each and receives 75 damage, it loses exactly 7 units and is left with 3 units at full health.

let units = 10
let hp = 10
let totalHP = units * hp
let damage = 75

let remainingHP = totalHP - damage


let addBack = remainingHP % units != 0


remainingHP / units + (addBack ? 1 : 0)





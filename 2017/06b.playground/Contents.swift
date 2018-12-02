import UIKit

var input = "4    1    15    12    0    9    9    5    5    8    7    3    14    5    12    3"
//input = "0  2   7   0"

var banks = input
    .components(separatedBy: .whitespaces)
    .filter { !$0.isEmpty }
    .compactMap { Int($0) }
print(banks)

func bankWithHighestBlock() -> Int {
    var index = 0
    var count = 0
    for (i, bank) in banks.enumerated() {
        if bank > count {
            index = i
            count = bank
        }
    }
    return index
}

func nextBank(after bank: Int) -> Int {
    if bank < banks.count - 1 {
        return bank + 1
    }
    return 0
}

func redistributeBlocks(in bank: Int) {
    var bank = bank
    var blocksToDistribute = banks[bank]
    banks[bank] = 0
    while blocksToDistribute > 0 {
        bank = nextBank(after: bank)
        banks[bank] += 1
        blocksToDistribute -= 1
    }
}

var cycle = 0
var duplicate = false
var snapshots = Set<[Int]>()
var cycleSnapshot = [[Int]: Int]()

while !duplicate {
    if snapshots.contains(banks) {
        duplicate = true
        continue
    }
    snapshots.insert(banks)
    cycleSnapshot[banks] = cycle
    let bank = bankWithHighestBlock()
    redistributeBlocks(in: bank)
    cycle += 1
    print(banks)
}

print(cycle)
let answer = cycle - cycleSnapshot[banks]!
print(answer)

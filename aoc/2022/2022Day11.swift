//
// Copyright © 2022 Paul Uhn. All rights reserved.
//

import Foundation

struct Y2022Day11 {

    struct Monkey {
        typealias MonkeyId = Int
        typealias WorryLevel = Int

        let id: MonkeyId
        var items: [WorryLevel]
        let operation: (WorryLevel) -> WorryLevel
        let test: (WorryLevel) -> MonkeyId
        var inspected = 0
    }

    static func Part0(_ data: String) {
        let monkeys = parse(data)

        assert(monkeys[0].id == 0)
        assert(monkeys[0].items == [79, 98])
        assert(monkeys[0].operation(1) == 19)
        assert(monkeys[0].test(23) == 2)
        assert(monkeys[0].test(1) == 3)

        assert(monkeys[1].id == 1)
        assert(monkeys[1].items == [54, 65, 75, 74])
        assert(monkeys[1].operation(1) == 7)
        assert(monkeys[1].test(19) == 2)
        assert(monkeys[1].test(1) == 0)

        assert(monkeys[2].id == 2)
        assert(monkeys[2].items == [79, 60, 97])
        assert(monkeys[2].operation(2) == 4)
        assert(monkeys[2].test(13) == 1)
        assert(monkeys[2].test(1) == 3)

        assert(monkeys[3].id == 3)
        assert(monkeys[3].items == [74])
        assert(monkeys[3].operation(1) == 4)
        assert(monkeys[3].test(17) == 0)
        assert(monkeys[3].test(1) == 1)
    }

    static func Part1(_ data: String, rounds: Int = 20) -> Int {
        var monkeys = parse(data)

        for _ in 0..<rounds {
            for i in 0..<monkeys.count {
                while !monkeys[i].items.isEmpty {
                    var item = monkeys[i].items.removeFirst()
                    item = monkeys[i].operation(item)
                    monkeys[i].inspected += 1
                    item /= 3
                    let monkeyId = monkeys[i].test(item)
                    monkeys[monkeyId].items.append(item)
                }
            }
        }
        let monkeyBusiness = monkeys
            .map { $0.inspected }
            .sorted()
            .suffix(2)
            .reduce(1, *)
        return monkeyBusiness
    }
}

private extension Y2022Day11 {
    typealias MonkeyId = Monkey.MonkeyId
    typealias WorryLevel = Monkey.WorryLevel

    static func parse(_ data: String) -> [Monkey] {
        let monkeys = data
            .split(separator: "\n\n")
            .map { parseMonkey($0) }
        return monkeys
    }

    private static func parseMonkey(_ data: Substring) -> Monkey {
        let data = data.split(separator: "\n")
        let id = parseId(data[0])
        let items = parseItems(data[1])
        let operation = parseOperation(data[2])
        let test = parseTest(data[3], data[4], data[5])

        let monkey = Monkey(id: id, items: items, operation: operation, test: test)
        return monkey
    }

    private static func parseId(_ data: Substring) -> MonkeyId {
        let regex = /^Monkey ([0-9]+):$/
        guard let results = try? regex.wholeMatch(in: data) else { fatalError() }

        let int = results.1.int
        return int
    }

    private static func parseItems(_ data: Substring) -> [WorryLevel] {
        let regex = /^  Starting items: ([0-9, ]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { fatalError() }

        let str = results.1.str
        let items = str
            .split(separator: ", ")
            .compactMap { WorryLevel($0) }
        return items
    }

    private static func parseOperation(_ data: Substring) -> (WorryLevel) -> WorryLevel {
        let regex = /^  Operation: new = old ([+*]) ([0-9]+|old)$/
        guard let results = try? regex.wholeMatch(in: data) else { fatalError() }

        let op = results.1.str
        let operand = results.2.str
        let isOld = operand == "old"

        return { worryLevel in
            let value = isOld ? worryLevel : operand.int
            switch op {
            case "+": return worryLevel + value
            case "*": return worryLevel * value
            default: fatalError()
            }
        }
    }

    private static func parseTest(_ data: Substring, _ t: Substring, _ f: Substring) -> (WorryLevel) -> MonkeyId {
        let regex = /^  Test: divisible by ([0-9]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { fatalError() }

        let int = results.1.int
        let t = parseTrue(t)
        let f = parseFalse(f)

        return { worryLevel in
            worryLevel % int == 0 ? t : f
        }
    }

    private static func parseTrue(_ data: Substring) -> MonkeyId {
        let regex = /^    If true: throw to monkey ([0-9]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { fatalError() }
        let int = results.1.int
        return int
    }

    private static func parseFalse(_ data: Substring) -> MonkeyId {
        let regex = /^    If false: throw to monkey ([0-9]+)$/
        guard let results = try? regex.wholeMatch(in: data) else { fatalError() }
        let int = results.1.int
        return int
    }
}

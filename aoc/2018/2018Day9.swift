//
//  2018Day9.swift
//  aoc
//
//  Created by Paul Uhn on 12/9/18.
//  Copyright © 2018 Rightpoint. All rights reserved.
//

import Foundation

struct Y2018Day9 {
    static func Part1(_ data: [String], _ multiplier: Int) -> [Int] {
        assert(MarbleMania("10 players; last marble is worth 1618 points")!.description == "10 players; last marble is worth 1618 points")
        
        let games = data.compactMap(MarbleMania.init)
        var hiScores = [Int]()
        for game in games {
            
            var marbles = CircularList<Int>()
            marbles.insert(1)
            marbles.insert(0)
            marbles.move(by: 1)

            var players = CircularList<Int>()
            for _ in 0..<game.playerCount {
                players.insert(0)
            }
            
            var marbleNumber = 1
            while marbleNumber < game.lastMarblePoint * multiplier {
                marbleNumber += 1

                if marbleNumber % 23 == 0 {
                    var currentScore = players.element()
                    marbles.move(by: -7)
                    currentScore += marbles.remove()
                    players.replace(currentScore + marbleNumber)

                } else {
                    marbles.move(by: 2)
                    marbles.insert(marbleNumber)
                }

                players.move(by: 1)
            }
            hiScores.append(players.data.sorted().last!)
        }
        return hiScores
    }
}

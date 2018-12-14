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
            
            let marbles = CircularList<Int>()
            marbles.append(0)
            marbles.append(1)
            var marbleNode = marbles.last!

            let players = CircularList<Int>()
            for _ in 0..<game.playerCount {
                players.append(0)
            }
            var playerNode = players.head!

            var marbleNumber = 1
            while marbleNumber < game.lastMarblePoint * multiplier {
                marbleNumber += 1

                if marbleNumber % 23 == 0 {
                    var currentScore = playerNode.value
                    marbleNode = marbles.get(marbleNode, offset: -6)
                    currentScore += marbles.remove(marbleNode.prev!)
                    playerNode.value = currentScore + marbleNumber

                } else {
                    marbleNode = marbles.get(marbleNode, offset: 2)
                    marbles.insert(before: marbleNode, marbleNumber)
                    marbleNode = marbles.get(marbleNode, offset: -1)
                }

                playerNode = players.get(playerNode, offset: 1)
            }
            hiScores.append(max(score: players))
        }
        return hiScores
    }
}
private extension Y2018Day9 {
    static func max(score players: CircularList<Int>) -> Int {
        var node = players.head!
        var scores = [node.value]
        
        for _ in 1..<players.count {
            node = node.next!
            scores.append(node.value)
        }
        return scores.sorted().last!
    }
}

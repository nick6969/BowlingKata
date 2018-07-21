//
//  BowlingGame.swift
//  BowlingKata
//
//  Created by Nick Lin on 2018/7/21.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

public extension Array {
    fileprivate subscript(safe index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index] : nil
    }
}

/// 計算分數時使用的 Error Type
///
/// - outsideOfRulesWithSingleHitPin: 單次擊球數量超過規則的範圍
/// - outsideOfRulesWithSingleRounds: 單個 rounds 擊球數量超過規則的範圍
enum CalculatedError: Error {
    case outsideOfRulesWithSingleHitPin
    case outsideOfRulesWithSingleRounds
}

private struct HitRounds {
    private(set) var first: Int = -1 {
        didSet {
            assert(first >= 0 && first <= 10)
        }
    }
    private(set) var secound: Int = -1 {
        didSet {
            assert(secound >= 0 && secound <= 10)
        }
    }

    var isStrike: Bool {
        return first == 10
    }

    var isSpare: Bool {
        if first != -1 && secound != -1 {
            return first + secound == 10
        }
        return false
    }

    var score: Int {
        if first != -1 && secound != -1 {
            return first + secound
        } else if first != -1 && secound == -1 {
            return first
        }
        return 0
    }

    /// 填入擊中球瓶
    ///
    /// - Parameter pin: 擊中的球瓶數
    /// - Returns: 是否要進入下一個 rounds
    /// - Throws: 擊中球瓶數量錯誤的時候會給 CalculatedError
    mutating func hitNumber(of pin: Int) throws -> Bool {
        if first == -1 {
            self.first = pin
            if pin == 10 {
                return true
            }
        } else {
            self.secound = pin
            if self.first + self.secound > 10 {
                throw CalculatedError.outsideOfRulesWithSingleRounds
            }
            return true
        }
        return false
    }

}

class BowlingGame {

    // A game of ten-pin bowling is divided into ten rounds
    private var rounds: Int = 0

    private lazy var hitRoundsArray: [HitRounds] = Array(repeating: HitRounds(), count: 10)

    func hitNumber(of pin: Int) throws {
        if pin > 10 || pin < 0 {
            throw CalculatedError.outsideOfRulesWithSingleHitPin
        }
        let nextRounds = try self.hitRoundsArray[rounds].hitNumber(of: pin)
        if nextRounds {
            rounds += 1
        }
    }

    func calculatedScore() -> Int {

        var score: Int = 0

        for i in 0 ... rounds {
            let round = hitRoundsArray[i]
            score += round.score

            if round.isStrike, let nextRound = hitRoundsArray[safe: i+1] {
                score += nextRound.score
                if nextRound.isStrike, let nextTwoRound = hitRoundsArray[safe: i+2] {
                    score += nextTwoRound.first
                }
            } else if round.isSpare, let nextRound = hitRoundsArray[safe: i+1] {
                score += nextRound.first
            }

        }
        return score
    }

}

//
//  BowlingGame.swift
//  BowlingKata
//
//  Created by Nick Lin on 2018/7/21.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class BowlingGame {

    private var hitPins: [Int] = []

    func hitNumber(of pin: Int) throws {
        if pin > 10 || pin < 0 {
            throw CalculatedError.outsideOfSingleHitPin
        }
        self.hitPins.append(pin)
    }

    func calculatedScore() throws -> Int {
        let score: Int = hitPins.reduce(0, +)
        if score > 10 {
            throw CalculatedError.outsideOfTwiceHitPin
        } else {
            return score
        }
    }

}

enum CalculatedError: Error {
    case outsideOfSingleHitPin
    case outsideOfTwiceHitPin
}

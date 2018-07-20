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
            throw CalculatedError.outsideTheRules
        }
        self.hitPins.append(pin)
    }

    func calculatedScore() -> Int {
        return hitPins.reduce(0, +)
    }

}

enum CalculatedError: Error {
    case outsideTheRules
}

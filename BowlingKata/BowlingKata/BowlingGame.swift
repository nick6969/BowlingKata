//
//  BowlingGame.swift
//  BowlingKata
//
//  Created by Nick Lin on 2018/7/21.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

class BowlingGame {

    func calculatedScore(hit: Int) -> Int {
        return hit
    }

}

enum CalculatedError: Error {
    case outsideTheRules
}

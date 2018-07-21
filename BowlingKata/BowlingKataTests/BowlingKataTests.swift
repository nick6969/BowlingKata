//
//  BowlingKataTests.swift
//  BowlingKataTests
//
//  Created by Nick Lin on 2018/7/21.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import XCTest
@testable import BowlingKata

class BowlingKataTests: XCTestCase {
    
    var game: BowlingGame!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = BowlingGame()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHitZeroPin() {
        do {
            try game.hitNumber(of: 0)
            let score = game.calculatedScore()
            XCTAssert(score == 0, "擊中 0 顆球瓶得分應該為 0, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現")
        }
    }

    func testHitOnePin() {
        do {
            try game.hitNumber(of: 1)
            let score = game.calculatedScore()
            XCTAssert(score == 1, "擊中 1 顆球瓶得分應該為 1, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現")
        }
    }

    func testHitElevenPin() {
        do {
            try game.hitNumber(of: 11)
            XCTAssert(false, "不應該出現可以擊中 11 顆球瓶的狀態")
        } catch {
            if let error = error as? CalculatedError {
                XCTAssert(error == CalculatedError.outsideOfRulesWithSingleHitPin, "這裡應該是單次擊球超出規則之外數量的錯誤")
            } else {
                XCTAssert(false, "不應該出現不是 CalculatedError 的 Error 型別")
            }
        }
    }

    func testHitNegativeNumberPin() {
        do {
            try game.hitNumber(of: -1)
            XCTAssert(false, "不應該出現可以擊中 -1 顆球瓶的狀態")
        } catch {
            if let error = error as? CalculatedError {
                XCTAssert(error == CalculatedError.outsideOfRulesWithSingleHitPin, "這裡應該是單次擊球超出規則之外數量的錯誤")
            } else {
                XCTAssert(false, "不應該出現不是 CalculatedError 的 Error 型別, error: \(error)")
            }
        }
    }

    func testHitTwice00() {
        do {
            // 兩次都擊中 0 顆的狀態
            try game.hitNumber(of: 0)
            try game.hitNumber(of: 0)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 0, "擊中 0 顆球瓶得分應該為 0")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testHitTwice01() {
        do {
            // 先擊中 1 顆 再擊中 0 顆的狀態
            try game.hitNumber(of: 1)
            try game.hitNumber(of: 0)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 1, "擊中 1 顆球瓶得分應該為 1")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testHitTwice02() {
        do {
            // 先擊中 0 顆 再擊中 1 顆的狀態
            try game.hitNumber(of: 0)
            try game.hitNumber(of: 1)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 1, "擊中 1 顆球瓶得分應該為 1")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testHitTwice03() {
        do {
            // 先擊中 5 顆 再擊中 6 顆的狀態
            try game.hitNumber(of: 5)
            try game.hitNumber(of: 6)
            let _ = game.calculatedScore()
            XCTAssert(false, "不應該有兩球相加超過 10的狀況")
        } catch {
            if let error = error as? CalculatedError {
                XCTAssert(error == CalculatedError.outsideOfRulesWithSingleRounds, "這裡應該是兩次擊球超出規則之外數量的錯誤")
            } else {
                XCTAssert(false, "不應該出現不是 CalculatedError 的 Error 型別, error: \(error)")
            }
        }
    }

    func testHasSpare00() {
        // 根據規則 單個 rounds 兩顆擊中球瓶數量 加起來為 10 則該次計分格的分數需要擊倒十瓶的10分再加上後面一次丟球所打倒的球瓶分數
        // 擊中 3 - 7 - 5 分數應該是 20
        do {
            try game.hitNumber(of: 3)
            try game.hitNumber(of: 7)
            try game.hitNumber(of: 5)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 20, "這裡分數應該是 20, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testHasSpare01() {
        do {
            try game.hitNumber(of: 1)
            try game.hitNumber(of: 3)
            try game.hitNumber(of: 8)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 12, "這裡分數應該是 12, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testHasStrike() {
        // 根據規則 單個 rounds 第一球擊中數量為10 則該次計分格的分數需要擊倒十瓶的10分再加上後面兩次丟球所打倒的球瓶分數。
        do {
            try game.hitNumber(of: 10)
            try game.hitNumber(of: 2)
            try game.hitNumber(of: 6)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 26, "這裡分數應該是 26, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testSpareAddStrike() {
        do {
            try game.hitNumber(of: 6)
            try game.hitNumber(of: 4)
            try game.hitNumber(of: 10)
            try game.hitNumber(of: 9)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 48, "這裡分數應該是 48, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testSpareAddStrike01() {
        do {
            try game.hitNumber(of: 10)
            try game.hitNumber(of: 6)
            try game.hitNumber(of: 4)
            try game.hitNumber(of: 9)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 48, "這裡分數應該是 48, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }

    func testDoubleStrike() {
        do {
            try game.hitNumber(of: 10)
            try game.hitNumber(of: 10)
            try game.hitNumber(of: 4)
            try game.hitNumber(of: 3)
            let score: Int = game.calculatedScore()
            XCTAssert(score == 48, "這裡分數應該是 48, 可是現在是 \(score)")
        } catch {
            XCTAssert(false, "不應該出現, error: \(error)")
        }
    }
}

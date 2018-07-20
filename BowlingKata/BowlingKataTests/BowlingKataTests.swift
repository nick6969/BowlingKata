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
            XCTAssert(score == 0, "擊中 0 顆球瓶得分應該為 0")
        } catch {
            XCTAssert(false, "不應該出現")
        }
    }

    func testHitOnePin() {
        do {
            try game.hitNumber(of: 1)
            let score = game.calculatedScore()
            XCTAssert(score == 1, "擊中 1 顆球瓶得分應該為 1")
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
                XCTAssert(error == .outsideTheRules, "這裡應該是超出規則之外的錯誤")
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
                XCTAssert(error == .outsideTheRules, "這裡應該是超出規則之外的錯誤")
            } else {
                XCTAssert(false, "不應該出現不是 CalculatedError 的 Error 型別")
            }
        }
    }

    func testHitTwice00() {
        do {
            // 兩次都擊中 0 顆的狀態
            try game.hitNumber(of: 0)
            try game.hitNumber(of: 0)
            XCTAssert(game.calculatedScore() == 0, "擊中 0 顆球瓶得分應該為 0")
        } catch {
            XCTAssert(false, "不應該出現")
        }
    }

    func testHitTwice01() {
        do {
            // 先擊中 1 顆 再擊中 0 顆的狀態
            try game.hitNumber(of: 1)
            try game.hitNumber(of: 0)
            XCTAssert(game.calculatedScore() == 1, "擊中 1 顆球瓶得分應該為 1")
        } catch {
            XCTAssert(false, "不應該出現")
        }
    }

    func testHintTwice02() {
        do {
            // 先擊中 0 顆 再擊中 1 顆的狀態
            try game.hitNumber(of: 0)
            try game.hitNumber(of: 1)
            XCTAssert(game.calculatedScore() == 1, "擊中 1 顆球瓶得分應該為 1")
        } catch {
            XCTAssert(false, "不應該出現")
        }
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

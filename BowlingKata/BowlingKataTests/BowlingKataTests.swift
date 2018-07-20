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
        XCTAssert(game.calculatedScore(hit: 0) == 0, "擊中 0 顆球瓶得分應該為 0")
    }

    func testHitOnePin() {
        XCTAssert(game.calculatedScore(hit: 1) == 1, "擊中 1 顆球瓶得分應該為 1")
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

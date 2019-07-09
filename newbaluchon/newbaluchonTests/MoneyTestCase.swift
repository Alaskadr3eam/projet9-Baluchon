//
//  MoneyTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
@testable import newbaluchon

class MoneyTestCase: XCTestCase {

    var money: Money!


    override func setUp() {
        super.setUp()
        money = Money()
       
       
    }
// test à TRUE si Realm ne contient pas d'object, si Realm contient un object alors FALSE
    func testRequestIsOk() {
        
        let result = money.requestIsOk
        
        XCTAssertEqual(result, false)

    }

    func testPrepareRate() {

        money.prepareArrayRate()
        
        XCTAssertEqual(money.dataSource1[0].code, "EUR")
        XCTAssertEqual(money.dataSource1[0].name, "Europe")
         XCTAssertNotEqual(money.dataSource1[0].name, "EURO")
        XCTAssertEqual(Constant.deviseSymbols.count, money.dataSource2.count)
    }


    func testRequestCurrency() {
        money.requestCurrency()
    }

    func testTimestamps() {
        let timestamps = Date().currentTime()
        
        let result = money.timeStampOfDay()
        
        XCTAssertEqual(timestamps,result)
    }

    func testExchangeDataSource() {
        money.isSwitch = false
        
        money.exchange()
        
        XCTAssertEqual(money.dataSource1.count, Constant.deviseSymbolsEuro.count)
        XCTAssertEqual(money.dataSource2.count, Constant.deviseSymbols.count)
        XCTAssertEqual(money.isSwitch, true)
    }

    func testExchangeDataSource2() {
        money.isSwitch = true
        
        money.exchange()
        
        XCTAssertEqual(money.dataSource1.count, Constant.deviseSymbols.count)
        XCTAssertEqual(money.dataSource2.count, Constant.deviseSymbolsEuro.count)
        XCTAssertEqual(money.isSwitch, false)
    }

    func testTimestampIsNotOk() {
        let result = money.timestampIsOk
        
        XCTAssertNotEqual(result,true)
        
    }







    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

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

    func resultatConversion() {
        money.arrayCurrencyEur["ZZZ"] = 1.5
    }

    func testRequestDevise() {
        money.requestDevise()
    }

    func testRequestCurrency() {
        money.requestCurrency()
    }

    func testResultConvertion() {
        money.arrayCurrencyEur["ZZZ"] = 1.5
        
       let result = money.resultConversion(value: "5", targetDevise: "ZZZ")
        
    XCTAssertEqual(result, "5*1.5")
    }

    func testCalcul() {
        money.arrayCurrencyEur["ZZZ"] = 1.5
        
        money.calcul(value: "5", targetDevise: "ZZZ")
        
        XCTAssertFalse(money.total == 5)
        XCTAssertEqual(money.total, 7.5)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

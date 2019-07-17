//
//  MoneyTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
import Realm
import RealmSwift

@testable import newbaluchon

class MoneyTestCase: XCTestCase {

    var money: Money!


    override func setUp() {
        super.setUp()
        money = Money(moneyServiceSession: MoneyService.shared)
       
       
    }

    func createTimeStampsOfDay() -> Int {
        var timestamps = money.timeStampOfDay()
        timestamps += 86400
        return Int(timestamps)
        
    }

    func createMoneyData() -> MoneyData {
        let rate = ["AED": 1.2,
                    "AFN": 1.5,
                    "ALL": 0.7,
                    "AMD": 0.2,
                    "ANG": 0.4,
                    "AOA": 0.6]
        let moneyData = MoneyData(timestamp: 120, base: "EUR", date: "2", success: true, rates: rate)
       return moneyData
    }
    
    func createMoneyData2() -> MoneyData {
        let rate = ["AED": 1.2,
                    "AFN": 1.5,
                    "ALL": 0.7,
                    "AMD": 0.2,
                    "ANG": 0.4,
                    "AOA": 0.6]
        let moneyData = MoneyData(timestamp: createTimeStampsOfDay(), base: "EUR", date: "2", success: true, rates: rate)
        return moneyData
    }
// test à TRUE si Realm ne contient pas d'object, si Realm contient un object alors FALSE
    func testRequestIsOk() {
        
        let result = money.requestIsOk
        
        XCTAssertEqual(result, true)
        XCTAssertEqual(money.objectsMoney.count, 0)

    }

    func testAllRequest() {

        money.allRequest()
    }

    func testAllRequest2() {
        let moneyData = createMoneyData()
        DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
        
        money.allRequest()
    }

    func testAllRequest3() {
        let moneyData = createMoneyData2()
        DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
        
        money.allRequest()
    }

    func testRequestCurrency() {
        let money1 = Money(moneyServiceSession: MoneyService(moneySession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        
        money1.requestCurrency()
        
        XCTAssertEqual(money1.errorMoney, NetworkError.emptyData)
        XCTAssertNil(money1.moneyCurrent)
    }

    func testRequestCurrency2() {
        let money1 = Money(moneyServiceSession: MoneyService(moneySession: URLSessionFake(data: FakeResponseData.moneyCorrectData, response: FakeResponseData.responseOK, error: nil)))
        
        money1.requestCurrency()
        
        XCTAssertNil(money1.errorMoney)
        XCTAssertNotNil(money1.moneyCurrent)
        XCTAssertEqual(money1.moneyCurrent!.success, true)
        XCTAssertEqual(money1.moneyCurrent!.timestamp, 1562242745)
    }



    func testAddDataMoney() {
        let moneyData = createMoneyData()
        
        DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
        
        XCTAssertEqual(money.objectsMoney.count, 1)
    }

    func testTimestampIsNotOk() {
        let moneyData1 = createMoneyData()
        DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData1)
        
        let bool = money.timestampIsOk
        
        XCTAssertNotEqual(bool,false)
    }

    func testPrepareRate() {

        money.prepareArrayRate()
        
        XCTAssertEqual(money.dataSource1[0].code, "EUR")
        XCTAssertEqual(money.dataSource1[0].name, "Europe")
         XCTAssertNotEqual(money.dataSource1[0].name, "EURO")
        XCTAssertEqual(Constant.deviseSymbols.count, money.dataSource2.count)
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

    func testDeleteDataMoney() {
        let moneyData = createMoneyData()
        DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
        
        DBManager.sharedInstance.deleteFromDbMoneyData(object: money.objectsMoney[0])
        
        XCTAssertEqual(money.objectsMoney.count, 0)
    }

    func testSearchDevise() {
        let moneyData = createMoneyData()
        DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
        
        let devise = money.searchDevise(deviseSearch: "AFN")
        
        XCTAssertEqual(devise, 1.5)
        XCTAssertNotEqual(devise, 1.2)
    }

    override func tearDown() {
        DBManager.sharedInstance.deleteAllFromDatabase()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

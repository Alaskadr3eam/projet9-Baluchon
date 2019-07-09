//
//  MoneyServiceTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//
import XCTest
@testable import newbaluchon

class MoneyServiceTestCase: XCTestCase {
    //let expectation = XCTestExpectation(description: "Wait for queue change")
    
    func testGetMoneyShouldPostFailedCallbackIfError() {
        // Given
        //let session = URLSessionFake(data: nil, response: nil, error: WeatherError.error)
        let moneyService = MoneyService(moneySession: URLSessionFake(data: nil, response: nil, error: TestError.error))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyService.getMoneyCurrent { (moneyData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.emptyData)
            XCTAssertNil(moneyData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetmoneyShouldPostFailedCallbackIfNoData() {
        // Given
        let moneyService = MoneyService(
            moneySession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyService.getMoneyCurrent { (moneyData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.emptyData)
            XCTAssertNil(moneyData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMoneyShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let moneyService = MoneyService(moneySession: URLSessionFake(data: FakeResponseData.moneyCorrectData,response: FakeResponseData.responseKO,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyService.getMoneyCurrent{ (moneyData,error) in
            // Then
            XCTAssertEqual(error,NetworkError.badResponse)
            XCTAssertNil(moneyData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMoneyShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let moneyService = MoneyService(moneySession: URLSessionFake(data: FakeResponseData.moneyIncorrectData,response: FakeResponseData.responseOK,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyService.getMoneyCurrent { (moneyData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.jsonDecodeFailed)
            XCTAssertNil(moneyData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMoneyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let moneyService = MoneyService(moneySession: URLSessionFake(data: FakeResponseData.moneyCorrectData,response: FakeResponseData.responseOK,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        moneyService.getMoneyCurrent { (moneyData,error) in
            
            //XCTAssertEqual(FakeResponseData.weatherCorrectData, weatherData)
            XCTAssertNil(error)
            XCTAssertEqual(moneyData!.timestamp, 1562242745)
            XCTAssertEqual(moneyData!.base, "EUR")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}

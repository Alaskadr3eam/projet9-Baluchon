//
//  TranslateServiceTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 26/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

import XCTest
@testable import newbaluchon

class TranslateServiceTestCase: XCTestCase {
    //let expectation = XCTestExpectation(description: "Wait for queue change")
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        //let session = URLSessionFake(data: nil, response: nil, error: WeatherError.error)
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: TestError.error))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(text: "Bonjour", source:"FR", target:"EN") { (translateData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.emptyData)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(text: "Bonjour", source:"FR", target:"EN") { (translateData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.emptyData)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(text: "Bonjour", source:"FR", target:"EN") { (translateData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.badResponse)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(text: "Bonjour", source:"FR", target:"EN") { (translateData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.jsonDecodeFailed)
            XCTAssertNil(translateData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslate(text: "Bonjour", source:"FR", target:"EN") { (translateData,error) in
            // Then
            XCTAssertNil(error)
            XCTAssertEqual(translateData?.data.translations[0].translatedText, "Hello")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}


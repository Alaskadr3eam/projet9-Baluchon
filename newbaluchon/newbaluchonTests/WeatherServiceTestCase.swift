//
//  WeatherServiceTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 26/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
@testable import newbaluchon

class WeatherServiceTestCase: XCTestCase {
    //let expectation = XCTestExpectation(description: "Wait for queue change")
    
    func testGetQuoteShouldPostFailedCallbackIfError() {
        // Given
        //let session = URLSessionFake(data: nil, response: nil, error: WeatherError.error)
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: WeatherError.error))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.emptyData)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))

    //When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    weatherService.getWeather(q: "Paris") { (weatherData,error) in
    // Then
    XCTAssertEqual(error, NetworkError.emptyData)
    XCTAssertNil(weatherData)
    expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 0.01)
}

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData,response: FakeResponseData.responseKO,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
            // Then
            XCTAssertEqual(error,NetworkError.badResponse)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData,response: FakeResponseData.responseOK,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.jsonDecodeFailed)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
       let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData,response: FakeResponseData.responseOK,error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather(q: "Paris") { (weatherData,error) in
            
            //XCTAssertEqual(FakeResponseData.weatherCorrectData, weatherData)
            XCTAssertNil(error)
            XCTAssertEqual(weatherData!.name, "Paris")
            XCTAssertEqual(weatherData!.main.temp, 301.34)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}





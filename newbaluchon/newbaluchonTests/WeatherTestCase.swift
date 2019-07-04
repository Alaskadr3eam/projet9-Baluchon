//
//  WeatherTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
@testable import newbaluchon

class WeatherTestCase: XCTestCase {

    var weather: Weather!

    override func setUp() {
        super.setUp()
       weather = Weather()
    }

    func requestWeather(q: String) {
        weather.requestWeather()
    }

    func requestWeatherLocation(q: String) {
        weather.requestWeatherLocation(city: q)
    }

    func requestWeatherNewCity(q: String) {
        weather.requestNewCity(city: q)
    }

    func testRequestIsOk() {
        //var objet = weather.objectsCity
        
        let result = weather.requestIsOk
    
        XCTAssertEqual(result, true)
    }

    func testRequest() {
        requestWeather(q: "Paris")
        
    }

    func testRequestLocation() {
        requestWeatherLocation(q: "Paris")
    }

    func testNewCity() {
        requestWeatherNewCity(q: "Paris")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

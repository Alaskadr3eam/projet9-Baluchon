//
//  WeatherTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
@testable import newbaluchon
//import RealmSwift

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
        
        let result = weather.requestIsOk
    
        XCTAssertEqual(result, true)
    }

    func testRequest() {
       // weather.objectsCity[0].name = "Paris"
        weather.requestWeather()
        
    }

    func testRequestLocation() {
        weather.requestWeatherLocation(city: "Paris")
    }

    func testNewCity() {
        weather.requestNewCityDomicile(city: "paris")
        
   
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

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
        weather.requestNewCityDomicile(city: q)
    }

    func requestReload(q: String, newWeather: WeatherHoliday, index: Int) {
        weather.requestNewCityReload(city: q, newWeather: newWeather, index: index)
    }
// test à TRUE si Realm ne contient pas d'object, si Realm contient un object alors FALSE
    func testRequestIsOk() {
        
        let result = weather.requestIsOk
    
        XCTAssertEqual(result, false)
    }

    func testRequest() {
        requestWeather(q: "paris")
    }

    func testRequestLocation() {
        requestWeatherLocation(q: "paris")
    }

    func testNewCity() {
        requestWeatherNewCity(q: "paris")
    }

   func testRequestReload() {
    let weather3 = WeatherHoliday()
        let weather1 = Weathers(id: 1, main: "ah", description: "beau", icon: "1n")
        let main1 = Main(temp: 20.0, pressure: 20.0, humidity: 20.0, temp_min: 20.0, temp_max: 20.0)
        let weatherTest = WeatherData(weather: [weather1], main: main1, name: "Paris")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherTest)
        requestReload(q: "paris", newWeather: weather3, index: 0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

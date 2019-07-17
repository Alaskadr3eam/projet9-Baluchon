//
//  WeatherTestCase.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 28/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import XCTest
import RealmSwift
import Realm

@testable import newbaluchon

class WeatherTestCase: XCTestCase {

    var weather: Weather!

    override func setUp() {
        super.setUp()
       weather = Weather(weatherServiceSession: WeatherService.shared)
    }

    func requestWeather(q: String) {
        weather.requestWeather()
    }

    func requestWeatherLocation(q: String) {
        weather.requestWeatherLocation(city: q)
    }

    func requestWeatherNewCityDomicile(q: String) {
        weather.requestNewCity(city: q)
        weather.requestNewCityDomicile(city: q)
    }

    func requestReload(q: String, newWeather: WeatherHoliday, index: Int) {
        weather.requestNewCityReload(city: q, newWeather: newWeather, index: index)
    }

    func createWeatherData(cityName: String) -> WeatherData {
        let weather1 = Weathers(id: 1, main: "ah", description: "beau", icon: "1n")
        let main1 = Main(temp: 20.0, pressure: 20.0, humidity: 20.0, temp_min: 20.0, temp_max: 20.0)
        let weatherTest = WeatherData(weather: [weather1], main: main1, name: cityName)
        return weatherTest
    }

    func createWeatherDataMultiple() {
        let weatherData1 = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherData1)
        let weatherData2 = createWeatherData(cityName: "NewYork")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherData2)
        let weatherData3 = createWeatherData(cityName: "Marseille")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherData3)
        let weatherData4 = createWeatherData(cityName: "Pignan")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherData4)
    }

    func createCityNameDomicile() -> CityNameDomicile {
        let weatherCityName = CityNameDomicile()
        weatherCityName.name = "Paris"
        weatherCityName.temperature = "20°C"
        weatherCityName.desctiptionWeather = "beau"
        weatherCityName.image = "1n"
        return weatherCityName
    }

    func testRequestIsNotOk() {
        
        let result = weather.requestIsOk
    
        XCTAssertEqual(result, true)
    }

    func testCreateObjectForNoLocation() {
        
        weather.createObjectForNoLoc()
        
        XCTAssertEqual(weather.objectsWeathers[0].name,"No Loc")
    }
//MARK: -Function for Weather request
    func testRequest() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        
        weather1.requestWeather()
        
       XCTAssertNil(weather1.weatherCity)
        XCTAssertEqual(weather1.objectsWeathers.count,0)
    }

    func testRequest2() {
         let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        let weatherData = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addOrUpdateDataCityName(weather: weatherData)
        
        weather1.requestWeather()
        
        XCTAssertEqual(weather1.errorWeather, NetworkError.emptyData)
    }

    func testRequest3() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)))
        let weatherData = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addOrUpdateDataCityName(weather: weatherData)
        
        weather1.requestWeather()
        
        XCTAssertNil(weather1.errorWeather)
        XCTAssertEqual(weather1.weatherCity.name, "Paris")
    }
    
    func testRequestLocation1() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        let city = "Paris"
       
        weather1.requestWeatherLocation(city: city)
        
        XCTAssertNil(weather1.weatherCity)
        XCTAssertEqual(weather1.errorWeather, NetworkError.emptyData)
    }

    func testRequestLocation2() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)))
        let city = "Paris"
       
        weather1.requestWeatherLocation(city: city)
        
        XCTAssertNil(weather1.errorWeather)
        XCTAssertEqual(weather1.weatherCity.name, "Paris")
    }

    func testRequestNewCityDomicile1() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        let city = "Paris"
        
        weather1.requestNewCityDomicile(city: city)
        
        XCTAssertNil(weather1.weatherCity)
        XCTAssertEqual(weather1.errorWeather, NetworkError.emptyData)
    }

    func testRequestNewCityDomicile2() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)))
        let city = "Paris"
        
        weather1.requestNewCityDomicile(city: city)
        
        XCTAssertNil(weather1.errorWeather)
        XCTAssertEqual(weather1.weatherCity.name, "Paris")
    }
    func testNewCity1() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        let city = "Paris"
        
        weather1.requestNewCity(city: city)
        
        XCTAssertNil(weather1.weatherCity)
        XCTAssertEqual(weather1.errorWeather, NetworkError.emptyData)
    }

    func testNewCity2() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)))
        let city = "Paris"
        
        weather1.requestNewCity(city: city)
        
        XCTAssertNil(weather1.errorWeather)
        XCTAssertEqual(weather1.weatherCity.name, "Paris")
    }

    func testNewCityReload1() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TestError.error)))
        createWeatherDataMultiple()
        let index = 1
        
        weather1.requestNewCityReload(city: weather.objectsWeathers[index].name!, newWeather: weather.objectsWeathers[index], index: index)
        
        XCTAssertNil(weather1.weatherCity)
        XCTAssertEqual(weather1.errorWeather, NetworkError.emptyData)
    }

    func testNewCityReload2() {
        let weather1 = Weather(weatherServiceSession: WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)))
        createWeatherDataMultiple()
        let index = 1
        
        weather1.requestNewCityReload(city: weather.objectsWeathers[index].name!, newWeather: weather.objectsWeathers[index], index: index)
        
        XCTAssertNil(weather1.errorWeather)
        XCTAssertEqual(weather1.weatherCity.name, "Paris")
    }


//MARK: -Function for DBManager for WeatherHoliday object
    func testAddWeatherHoliday() {
        let weatherTest = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherTest)
        
        XCTAssertEqual(weather.objectsWeathers.count, 1)
        
        DBManager.sharedInstance.deleteAllFromDatabase()
    }
    
    func testDeleteWeatherHoliday() {
        let weatherTest = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherTest)
        
        DBManager.sharedInstance.deleteFromDbWeatherHoliday(object: weather.objectsWeathers[0])
        
        XCTAssertEqual(weather.objectsWeathers.count, 0)
        
    }
    
    func testUpdateWeatherHoliday() {
        let weatherTest = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherTest)
        let weatherTest2 = createWeatherData(cityName: "NewYork")
        let newWeather = weather.objectsWeathers[0]
        
        DBManager.sharedInstance.update(newweather1: newWeather, weatherData: weatherTest2)
        
        XCTAssertEqual(weather.objectsWeathers[0].name, "NewYork")
        
    }
    
    func testUpdateWeatherLocation() {
        let weatherTest = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherTest)
        let weatherTest2 = createWeatherData(cityName: "NewYork")
        
        DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherTest2)
        
        XCTAssertNotEqual(weather.objectsWeathers[0].name, "Paris")
        XCTAssertEqual(weather.objectsWeathers[0].name, "NewYork")
    }
    
    func testAddOrUpdateWeatherHoliday() {
        let weatherTest2 = createWeatherData(cityName: "NewYork")
        
        DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherTest2)
        
        XCTAssertEqual(weather.objectsWeathers[0].name, "NewYork")
        
    }
    
    func testAddOrUpdateWeatherHoliday2() {
        let weatherTest2 = createWeatherData(cityName: "NewYork")
        
        DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherTest2)
        
        XCTAssertEqual(weather.objectsWeathers[0].name, "NewYork")
        
        DBManager.sharedInstance.deleteAllFromDatabase()
        
    }

    //MARK: -Function for DBManager for CityNameDomicile object

    func testAddDataCityNameDomicile() {
        let weatherData = createWeatherData(cityName: "Paris")
        
        DBManager.sharedInstance.addOrUpdateDataCityName(weather: weatherData)
        
        XCTAssertEqual(weather.objectsCity[0].name, "Paris")
        XCTAssertEqual(weather.objectsCity[0].desctiptionWeather, "beau")
        XCTAssertNotEqual(weather.objectsCity.count, 0)
        XCTAssertNotEqual(weather.objectsCity.count, 2)
        XCTAssertEqual(weather.objectsCity.count, 1)
        
    }

    func testDeleteCityNameDomcile() {
        let cityDomicile = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addDataCityNameDomicile(weather: cityDomicile)
        
        let cityDomicileDelete = weather.objectsCity[0]
        
        DBManager.sharedInstance.deleteFromDbCityNameDomicile(object: cityDomicileDelete)

        XCTAssertEqual(weather.objectsCity.count,0)
    }

    func testUpdateDataCityNameDomicile() {
        let cityDomicile = createWeatherData(cityName: "Paris")
        DBManager.sharedInstance.addDataCityNameDomicile(weather: cityDomicile)
        let weatherData = createWeatherData(cityName: "NewYork")
    
        DBManager.sharedInstance.addOrUpdateDataCityName(weather: weatherData)
        
        XCTAssertEqual(weather.objectsCity[0].name, "NewYork")
        XCTAssertNotEqual(weather.objectsCity.count, 0)
        XCTAssertNotEqual(weather.objectsCity.count, 2)
        XCTAssertEqual(weather.objectsCity.count, 1)
    }
//MARK: -Function for Test Func Enum Error
    func testErrorEnum() {
        let error = NetworkError.badResponse
        
        _ = NetworkError.getAlert(error)
       
        XCTAssert(true, "The request returned a bad response")
        
    }

    override func tearDown() {
        DBManager.sharedInstance.deleteAllFromDatabase()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

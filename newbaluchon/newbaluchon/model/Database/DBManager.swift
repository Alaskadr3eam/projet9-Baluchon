//
//  DBManager.swift
//  newbaluchon
//
//  Created by Clément Martin on 15/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import RealmSwift

class DBManager {
    
    
    var   database: Realm
    
    
    static let   sharedInstance = DBManager()
    
    
    private init() {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            let configuration = Realm.Configuration(inMemoryIdentifier: "Test", schemaVersion: 1)
            database = try! Realm(configuration: configuration)
        } else {
            let configuration = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = configuration
            database = try! Realm()
        }
    }

    func deleteAllFromDatabase()  {
        
        try!   database.write {
            
            database.deleteAll()
        }
    }
    
    //MARK: -Function for DBMoneyAndDevise
    
    func getDataFromDBMoneyDataRealm() ->   Results<MoneyDataRealm> {
        let results = database.objects(MoneyDataRealm.self)
        return results
    }
    
    func addDataMoneyDataRealm(money: MoneyData)   {
        let moneyDataRealm = MoneyDataRealm()
        moneyDataRealm.timestamps = money.timestamp
        // moneyDataRealm.date = money.date
        var i = 0
        for (key,value) in money.rates {
            let rate = Rate()
            rate.symbols = key
            rate.currencyValue = value
            moneyDataRealm.symbols.append(rate)
            i += 1
        }
        try! database.write {
            database.add(moneyDataRealm)
        }
    }
    
    func deleteFromDbMoneyData(object: MoneyDataRealm)   {
        
        try!   database.write {
            
            database.delete(object)
        }
    }
    
    //MARK: -Function for DBCityNameDomicile
    
    func getDataFromDBCityNameDomicile() ->   Results<CityNameDomicile> {
        
        let results = database.objects(CityNameDomicile.self)
        return results
    }
    
    func addDataCityNameDomicile(weather: WeatherData)   {
        let weatherCityName = CityNameDomicile()
        weatherCityName.name = weather.name
        weatherCityName.temperature = "\(weather.main.temp)°C"
        weatherCityName.desctiptionWeather = weather.weather[0].description
        weatherCityName.image = weather.weather[0].icon
        try! database.write {
            database.add(weatherCityName)
        }
    }
    
    func deleteFromDbCityNameDomicile(object: CityNameDomicile)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
    func updateDataCityNameDomicile(weather: WeatherData) {
        if let newWeather = DBManager.sharedInstance.getDataFromDBCityNameDomicile().first {
            try! database.write {
                newWeather.name = weather.name
                newWeather.temperature = String(weather.main.temp)
                newWeather.desctiptionWeather = weather.weather[0].description
                newWeather.image = weather.weather[0].icon
            }
        }
    }
    
    func addOrUpdateDataCityName(weather: WeatherData) {
        if DBManager.sharedInstance.getDataFromDBCityNameDomicile().count == 0 {
            addDataCityNameDomicile(weather: weather)
        } else {
            updateDataCityNameDomicile(weather: weather)
        }
    }
    
    //MARK: -Function for DBWeatherHoliday
    
    func getDataFromDBWeatherHoliday() ->   Results<WeatherHoliday> {
        let results = database.objects(WeatherHoliday.self)
        return results
    }
    
    func addDataWeatherHoliday(object: WeatherHoliday)   {
        try! database.write {
            database.add(object)
        }
    }
    
    func addDataWeatherHoliday(weather: WeatherData)   {
        let weatherHoliday = WeatherHoliday()
        weatherHoliday.name = weather.name
        weatherHoliday.temperature = "\(weather.main.temp)"
        weatherHoliday.descriptionWeather = weather.weather[0].description
        weatherHoliday.image = weather.weather[0].icon
        try! database.write {
            database.add(weatherHoliday)
        }
    }
    
    func deleteFromDbWeatherHoliday(object: WeatherHoliday)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
    func update(newweather1: WeatherHoliday, weatherData: WeatherData) {
        let newWeather = newweather1
        try! database.write {
            newWeather.name = weatherData.name
            newWeather.temperature = String(weatherData.main.temp)
            newWeather.descriptionWeather = weatherData.weather[0].description
            newWeather.image = weatherData.weather[0].icon
        }
    }
    
    func updateDataWeather(weather: WeatherData) {
        if let newWeather = DBManager.sharedInstance.getDataFromDBWeatherHoliday().first {
            try! database.write {
                newWeather.name = weather.name
                newWeather.temperature = String(weather.main.temp)
                newWeather.descriptionWeather = weather.weather[0].description
                newWeather.image = weather.weather[0].icon
            }
        }
    }
    
    func addOrUpdateDataWeatherHolidayFirst(weather: WeatherData) {
        if DBManager.sharedInstance.getDataFromDBWeatherHoliday().count == 0 {
            addDataWeatherHoliday(weather: weather)
        } else {
            updateDataWeather(weather: weather)
        }
    }
    
}


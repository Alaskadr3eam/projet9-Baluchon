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
    
    //var Object1: Results<CityNameDomcile>? = nil
    
    private init() {
    
      let configuration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    
                    
                    // if you want to fill a new property with some values you have to enumerate
                    // the existing objects and set the new value
                    migration.enumerateObjects(ofType: CityNameDomicile.className()) { oldObject, newObject in
                        newObject!["temperature"] = String()
                        newObject!["desctiptionWeather"] = String()
                        newObject!["temperature"] = String()
                        newObject!["image"] = String()
                    }
                    
                    migration.enumerateObjects(ofType: MoneyDataRealm.className()) { oldObject, newObject in
                        newObject!["date"] = String()
                    }
                    
                    // if you added a new property or removed a property you don't
                    // have to do anything because Realm automatically detects that
                }
        }
        )
        Realm.Configuration.defaultConfiguration = configuration
        
        // opening the Realm file now makes sure that the migration is performed
       // let realm = try! Realm()
        
        database = try! Realm()
    
        
    }
    


    func deleteAllFromDatabase()  {
        
        try!   database.write {
            
            database.deleteAll()
            
        }
        print("all deleted")
    }

    //MARK: -Function for DBMoneyAndDevise

    func getDataFromDBMoneyDataRealm() ->   Results<MoneyDataRealm> {
        
        let results = database.objects(MoneyDataRealm.self)
        
        return results
        
    }
/*
    func getDataFromDBSymbolsDataRealm() ->   Results<SymbolsDataRealm> {
        
        let results = database.objects(SymbolsDataRealm.self)
        
        return results
        
    }

    func addDataSymbolsDataRealm(symbols: DeviseData) {
        
        for (key,value) in symbols.symbols {
            let symbolsDataRealm = SymbolsDataRealm()
            symbolsDataRealm.code = key
            symbolsDataRealm.name = value
            try! database.write {
                database.add(symbolsDataRealm)
                print("Added / Update new object")
            }
        }
    }

    func deleteFromDbSymbolsDataRealm(object: SymbolsDataRealm)   {
        
        try!   database.write {
            
            database.delete(object)
            
        }
        
    }
*/
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
            print("Added / Update new object")
        }
    }

    func deleteFromDbMoneyData(object: MoneyDataRealm)   {
        
        try!   database.write {
            
            database.delete(object)
            
        }
        
    }
/*
    func getDataFromDBRateDataRealm() ->   Results<Rate> {
        
        let results = database.objects(Rate.self)
        
        return results
        
    }
*/
    func addDataDeviseData(object: MoneyDataRealm)   {
        
        try! database.write {
            
            database.add(object)
            
            print("Added / Update new object")
            
        }
        
    }

    //MARK: -Function for DBCityNameDomicile

    func getDataFromDBCityNameDomicile() ->   Results<CityNameDomicile> {
        
        let results = database.objects(CityNameDomicile.self)
        
        return results
        
    }
   
    func addDataCityNameDomicile(object: CityNameDomicile)   {
        
        try! database.write {
            
            database.add(object)
            
            print("Added / Update new object")
            
        }
        
    }

    func addDataCityNameDomicile(weather: WeatherData)   {
        let weatherCityName = CityNameDomicile()
        weatherCityName.name = weather.name
        weatherCityName.temperature = "\(weather.main.temp)°C"
        weatherCityName.desctiptionWeather = weather.weather[0].description
        weatherCityName.image = weather.weather[0].icon
        try! database.write {
            database.add(weatherCityName)
            print("Added / Update new object")
        }
    }
    
    func deleteFromDbCityNameDomicile(object: CityNameDomicile)   {
        
        try!   database.write {
            
            database.delete(object)
            
        }
        
    }
    
    func updateDataCity(city: String, object: CityNameDomicile) {
       
            try! database.write {
                object.name = city
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

/*
    func addOrUpdateDataFirst(city: String) {
            let cityRealm = CityNameDomicile()
            cityRealm.name = city
            addDataCityNameDomicile(object: cityRealm)
        } else {
            updateDataCity(city: city)
        }
    }
}
    
*/
  

    //MARK: -Function for DBWeatherHoliday

    func getDataFromDBWeatherHoliday() ->   Results<WeatherHoliday> {
        
        let results = database.objects(WeatherHoliday.self)
        
        return results
        
    }
    
    func addDataWeatherHoliday(weather: WeatherData)   {
        let weatherHoliday = WeatherHoliday()
        weatherHoliday.name = weather.name
        weatherHoliday.temperature = "\(weather.main.temp)"
        weatherHoliday.descriptionWeather = weather.weather[0].description
        weatherHoliday.image = weather.weather[0].icon
        try! database.write {
            database.add(weatherHoliday)
            print("Added / Update new object")
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
/*
func getDataFromDBCityNameDomicile() ->   Results<CityNameDomicile> {
 
    let results = database.objects(CityNameDomicile.self)
 
    return results
 
}

func addDataCityNameDomicile(object: CityNameDomicile)   {
 
    try! database.write {
 
        database.add(object)
 
        print("Added / Update new object")
 
    }
 
}

func deleteFromDbCityNameDomicile(object: CityNameDomicile)   {
 
    try!   database.write {
 
        database.delete(object)
 
    }
 
}

func updateDataCity(city: String) {
    if let newCity = weather.objectsCity?.first {
        try! database.write {
            newCity.name = city
        }
    }
}

func addOrUpdateDataFirst(city: String) {
    if DBManager.sharedInstance.getDataFromDBCityNameDomicile().count == 0 {
        let cityRealm = CityNameDomicile()
        cityRealm.name = city
        addDataCityNameDomicile(object: cityRealm)
    } else {
        updateDataCity(city: city)
    }
}
*/

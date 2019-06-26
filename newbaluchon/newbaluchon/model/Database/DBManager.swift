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
        
        database = try! Realm()
        
    }
    


    func deleteAllFromDatabase()  {
        
        try!   database.write {
            
            database.deleteAll()
            
        }
        print("all deleted")
    }

    //MARK: -Function for DBMoneyAndDevise
/*
    func getDataFromDBDeviseDataRealm() ->   Results<DeviseDataRealm> {
        
        let results = database.objects(DeviseDataRealm.self)
        
        return results
        
    }

    func addDataDeviseData(object: DeviseDataRealm)   {
        
        try! database.write {
            
            database.add(object)
            
            print("Added / Update new object")
            
        }
        
    }
*/
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
        weatherHoliday.temperature = "\(weather.main.temp)°C"
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

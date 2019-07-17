//
//  File.swift
//  newbaluchon
//
//  Created by Clément Martin on 20/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

import RealmSwift


class Weather {
    
    var delegateScreenWeather: UpdateWeatherViewDelegate?
    var delegateAddCityHoliday: AddCityHolidayDelegate?
    var delegateAlertError: AlertDelegate?
    var delegateViewIsHidden: IsHiddenDelegate?
    
   //var weatherCity = [WeatherDataCity]()
    var cityLocation = String()
    var countryLocation = String()
    
    var weatherCity: WeatherData!
    
    var errorWeather: NetworkError!
    
    var objectsWeathers = DBManager.sharedInstance.getDataFromDBWeatherHoliday()
    var objectsCity = DBManager.sharedInstance.getDataFromDBCityNameDomicile()
    
    
    var requestIsOk: Bool {
        return objectsCity.count == 0
    }
    
    private var weatherServiceSession = WeatherService(weatherSession: URLSession(configuration: .default))
    init(weatherServiceSession: WeatherService) {
        self.weatherServiceSession = weatherServiceSession
    }
    
    func createObjectForNoLoc() {
        
        if objectsWeathers.count == 0 {
            let weatherLoc = WeatherHoliday()
            weatherLoc.name = "No Loc"
            weatherLoc.descriptionWeather = "No Loc"
            weatherLoc.temperature = "No"
            weatherLoc.image = "no Loc"
            DBManager.sharedInstance.addDataWeatherHoliday(object: weatherLoc)
        }
        requestWeather()
        
        // weather.requestWeather()
    }
    
    func requestWeather() {
        if requestIsOk {
            delegateScreenWeather?.perfomSegueIsCalled()
            return
        } else {
            self.delegateViewIsHidden?.viewDomicileIsHidden()
            if let q = objectsCity[0].name {
            weatherServiceSession.getWeather(q: q) { [weak self] (weatherData, error) in
                guard let self = self else {
                    return
                }
                self.delegateViewIsHidden?.viewDomicileIsNotHidden()
                if let error = error {
                    self.errorWeather = error
                    
                    self.delegateAlertError?.alertError(self.errorWeather)
                    
                    return
                }
                guard let weatherData = weatherData else {
                    return
                }
                self.weatherCity = weatherData
                self.delegateScreenWeather?.itIsResultRequest(weatherData: self.weatherCity)
                if self.cityLocation.isEmpty == true && self.countryLocation.isEmpty == true {
                    self.delegateScreenWeather?.doLocation()
                }
                self.requestWeatherLocation(city: ("\(self.cityLocation), \(self.countryLocation)"))
            }
        }
        }
    }
    
    func requestWeatherLocation(city: String) {
        self.delegateViewIsHidden?.cellIsHidden()
        weatherServiceSession.getWeather(q:city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            self.delegateViewIsHidden?.cellIsNotHidden()
            if let error = error {
                self.errorWeather = error
                self.delegateAlertError?.alertError(self.errorWeather)
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            self.weatherCity = weatherData
            self.delegateScreenWeather?.itISResultRequestLocation(weatherData: self.weatherCity)
        }
        delegateScreenWeather?.itIsResultRequestLocationInCollectionView()
    }
    
    func requestNewCityDomicile(city: String) {
        weatherServiceSession.getWeather(q: city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            self.delegateViewIsHidden?.viewDomicileIsNotHidden()
            if let error = error {
                self.errorWeather = error
                self.delegateAlertError?.alertError(self.errorWeather)
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            self.weatherCity = weatherData
            self.delegateScreenWeather?.itIsResultRequest(weatherData: self.weatherCity)
            if self.cityLocation.isEmpty != true && self.countryLocation.isEmpty != true {
                self.requestWeatherLocation(city: ("\(self.cityLocation), \(self.countryLocation)"))
            }
        }
        
    }
    
    func requestNewCity(city: String) {
        weatherServiceSession.getWeather(q: city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.errorWeather = error
                self.delegateAlertError?.alertError(self.errorWeather)
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            self.weatherCity = weatherData
            self.delegateAddCityHoliday?.itISResultRequestNewCityHoliday(weatherData: self.weatherCity)
        }
        self.delegateAddCityHoliday?.updateTableViewWeather()
    }
    
    func requestNewCityReload(city: String, newWeather: WeatherHoliday, index: Int) {
        self.delegateViewIsHidden?.cellIsHidden()
        weatherServiceSession.getWeather(q: city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            self.delegateViewIsHidden?.cellIsNotHidden()
            if let error = error {
                self.errorWeather = error
                self.delegateAlertError?.alertError(self.errorWeather)
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            self.weatherCity = weatherData
            DispatchQueue.main.async {
                self.delegateScreenWeather?.itIsResultRequestReloadCell(weatherdata: self.weatherCity, newWeather: self.objectsWeathers[index], index: index)
            }
        }
    }
}

protocol UpdateWeatherViewDelegate {
    func itIsResultRequest(weatherData: WeatherData)
    func itISResultRequestLocation(weatherData: WeatherData)
    func itIsResultRequestLocationInCollectionView()
    func itIsResultRequestReloadCell(weatherdata: WeatherData, newWeather: WeatherHoliday, index: Int)
    func perfomSegueIsCalled()
    func doLocation()
}

protocol AddCityHolidayDelegate {
    func itISResultRequestNewCityHoliday(weatherData: WeatherData)
    func updateTableViewWeather()
}

protocol AlertDelegate {
    func alertError(_ error: NetworkError)
}

protocol IsHiddenDelegate {
    func viewDomicileIsHidden()
    func viewDomicileIsNotHidden()
    func cellIsHidden()
    func cellIsNotHidden()
}

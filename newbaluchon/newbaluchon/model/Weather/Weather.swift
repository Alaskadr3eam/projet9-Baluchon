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
    var delegatePerformSegue: PerfomSegueDelegate?
    var delegateAddCityHoliday: AddCityHolidayDelegate?
    var delegateAlertError: AlertDelegate?
    var delegateViewIsHidden: IsHiddenDelegate?
    
    var weatherCity = [WeatherDataCity]()
    var cityLocation = String()
    var countryLocation = String()
    

    
    var objectsWeathers = DBManager.sharedInstance.getDataFromDBWeatherHoliday()
    var objectsCity = DBManager.sharedInstance.getDataFromDBCityNameDomicile()


    var requestIsOk: Bool {
        return objectsCity.count == 0
    }

    func addDataCityNameDomicile(object: CityNameDomicile)   {
       DBManager.sharedInstance.addDataCityNameDomicile(object: object)
    }

    func requestWeather() {
        if requestIsOk {
            delegatePerformSegue?.perfomSegueIsCalled()
            return
        } else {
           self.delegateViewIsHidden?.viewDomicileIsHidden()
            WeatherService.shared.getWeather(q: objectsCity[0].name!) { [weak self] (weatherData, error) in
                guard let self = self else {
                    return
                }
              self.delegateViewIsHidden?.viewDomicileIsNotHidden()
                if let error = error {
                    self.delegateAlertError?.alertError(error)
                    return
                }
                guard let weatherData = weatherData else {
                    self.delegateAlertError?.alertError(NetworkError.emptyData)
                    return
                }
                self.delegateScreenWeather?.itIsResultRequest(weatherData: weatherData)
                self.requestWeatherLocation(city: ("\(self.cityLocation), \(self.countryLocation)"))
            }
        }
    }

    func requestWeatherLocation(city: String) {
       self.delegateViewIsHidden?.cellIsHidden()
        WeatherService.shared.getWeather(q:city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            self.delegateViewIsHidden?.cellIsNotHidden()
            if let error = error {
                self.delegateAlertError?.alertError(error)
                return
            }
            guard let weatherData = weatherData else {
                self.delegateAlertError?.alertError(NetworkError.emptyData)
                return
            }
            
            self.delegateScreenWeather?.itISResultRequestLocation(weatherData: weatherData)
        }
        delegateScreenWeather?.itIsResultRequestLocationInCollectionView()
    }

    func requestNewCityDomicile(city: String) {
        WeatherService.shared.getWeather(q: city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.delegateAlertError?.alertError(error)
                return
            }
            guard let weatherData = weatherData else {
                self.delegateAlertError?.alertError(NetworkError.emptyData)
                return
            }
           /* DispatchQueue.main.async {
                DBManager.sharedInstance.addOrUpdateDataCityName(weather: weatherdata)
            }*/
           // self.delegateAddCityHoliday?.itISResultRequestNewCityHoliday(weatherData: weatherData)
            self.delegateScreenWeather?.itIsResultRequest(weatherData: weatherData)
        }
        
       //self.delegateAddCityHoliday?.updateTableViewWeather()
        //tableView.reloadData()
    }

    func requestNewCity(city: String) {
        WeatherService.shared.getWeather(q: city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.delegateAlertError?.alertError(error)
                return
            }
            guard let weatherData = weatherData else {
                self.delegateAlertError?.alertError(NetworkError.emptyData)
                return
            }
            self.delegateAddCityHoliday?.itISResultRequestNewCityHoliday(weatherData: weatherData)
        }
        self.delegateAddCityHoliday?.updateTableViewWeather()
    }

    func requestNewCityReload(city: String, newWeather: WeatherHoliday, index: Int) {
         self.delegateViewIsHidden?.cellIsHidden()
        WeatherService.shared.getWeather(q: city) { [weak self] (weatherData, error) in
            guard let self = self else {
                return
            }
            self.delegateViewIsHidden?.cellIsNotHidden()
            if let error = error {
                self.delegateAlertError?.alertError(error)
                return
            }
            guard let weatherData = weatherData else {
                self.delegateAlertError?.alertError(NetworkError.emptyData)
                return
            }
            DispatchQueue.main.async {
            self.delegateScreenWeather?.itIsResultRequestReloadCell(weatherdata: weatherData, newWeather: self.objectsWeathers[index], index: index)
            }
          /*  DispatchQueue.main.async {
                DBManager.sharedInstance.update(newweather1: self.objectsWeathers[index], weatherData: weatherData)
            }*/
        }
       // self.delegateAddCityHoliday?.updateTableViewWeather()
    }

}

protocol UpdateWeatherViewDelegate {
    func itIsResultRequest(weatherData: WeatherData)
    func itISResultRequestLocation(weatherData: WeatherData)
    func itIsResultRequestLocationInCollectionView()
    func itIsResultRequestReloadCell(weatherdata: WeatherData, newWeather: WeatherHoliday, index: Int)
}

protocol AddCityHolidayDelegate {
    func itISResultRequestNewCityHoliday(weatherData: WeatherData)
    func updateTableViewWeather()
}

protocol PerfomSegueDelegate {
    func perfomSegueIsCalled()
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

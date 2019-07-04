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
           self.delegateViewIsHidden?.viewIsHidden()
            WeatherService.shared.getWeather(q: objectsCity[0].name!) { [weak self] (weatherData, error) in
                guard let self = self else {
                    return
                }
              self.delegateViewIsHidden?.viewIsNotHidden()
                if let error = error {
                    self.delegateAlertError?.alertError(error)
                    return
                }
                guard let weatherData = weatherData else {
                    return
                }
                self.delegateScreenWeather?.itIsResultRequest(weatherData: weatherData)
            }
        }
    }

    func requestWeatherLocation(city: String) {
        self.delegateViewIsHidden?.viewIsHidden()
        WeatherService.shared.getWeather(q:city) { (weatherData, error) in
            if let error = error {
                self.delegateAlertError?.alertError(error)
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            self.delegateScreenWeather?.itISResultRequestLocation(weatherData: weatherData)
        }
        delegateScreenWeather?.itIsResultRequestLocationInCollectionView()
    }

    func requestNewCityDomicile(city: String) {
        WeatherService.shared.getWeather(q: city) { (weatherData, error) in
            if let error = error {
                
                return
            }
            guard let weatherData = weatherData else {
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
        WeatherService.shared.getWeather(q: city) { (weatherData, error) in
            if let error = error {
                
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            self.delegateAddCityHoliday?.itISResultRequestNewCityHoliday(weatherData: weatherData)
        }
        self.delegateAddCityHoliday?.updateTableViewWeather()
        //tableView.reloadData()
    }

    func requestNewCityReload(city: String, newWeather: WeatherHoliday, index: Int) {
        WeatherService.shared.getWeather(q: city) { (weatherData, error) in
            if let error = error {
                
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            DispatchQueue.main.async {
                DBManager.sharedInstance.update(newweather1: self.objectsWeathers[index], weatherData: weatherData)
            }
            //self.delegateAddCityHoliday?.itISResultRequestNewCityHoliday(weatherData: weatherData)
        }
        self.delegateAddCityHoliday?.updateTableViewWeather()
        //tableView.reloadData()
    }

}

protocol UpdateWeatherViewDelegate {
    func itIsResultRequest(weatherData: WeatherData)
    func itISResultRequestLocation(weatherData: WeatherData)
    func itIsResultRequestLocationInCollectionView()
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
    func viewIsHidden()
    func viewIsNotHidden()
}

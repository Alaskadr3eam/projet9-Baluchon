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
    
    var weatherCity = [WeatherDataCity]()

    
    var objectsWeathers = DBManager.sharedInstance.getDataFromDBWeatherHoliday()
    var objectsCity = DBManager.sharedInstance.getDataFromDBCityNameDomicile()

    //var objectCity2: Results<CityNameDomicile>? = nil

    enum TotalCaculError: Error {
        case calculImpossible
        
        var displayString: String {
            switch self {
            case .calculImpossible:
                return "Erreur calcul impossible en informatique sinon = 0"
            }
        }
    }

    func requestIsPossible() throws {
        guard objectsCity.count != 0 else {
        throw
    TotalCaculError.calculImpossible
            
        }
    }

    var domicileOKI: Bool {
       let reponse = dityDomicileOK()
        return reponse
    }
    
    func dityDomicileOK() -> Bool{
        do {
            try requestIsPossible()
        } catch {
            delegatePerformSegue?.perfomSegueIsCalled()
            return false
        }
        return true
        
        /*
        if objectsCity == nil {
            delegatePerformSegue?.perfomSegueIsCalled()
        } else {
            return
        }
 */
    }

    func addDataCityNameDomicile(object: CityNameDomicile)   {
       DBManager.sharedInstance.addDataCityNameDomicile(object: object)
    }

    func addNewCity(city: String) {
        do {
            try requestIsPossible()
        } catch {
            let cityRealm = CityNameDomicile()
            cityRealm.name = city
            DBManager.sharedInstance.addDataCityNameDomicile(object: cityRealm)
            return
           
        }
            if let newCity = objectsCity.first {
                DBManager.sharedInstance.updateDataCity(city: city, object: newCity)
    }
    }
/*
    func requestWeather() {
        if !domicileOKI {
            return
        }
        WeatherService.shared.getWeather(city: objectsCity[0].name!) { (weatherData, error) in
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
*/
    func requestWeather() {
        if !domicileOKI {
            return
        }
        WeatherService.shared.getWeather(q: objectsCity[0].name!) { (weatherData, error) in
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
    /*
    func requestWeatherLocation(city: String, country: String) {
        
        WeatherService.shared.getWeatherLocation(city: "\(city),\(country)") { (weatherData, error) in
            if let error = error {
                //alert
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            /*
            DispatchQueue.main.async {
                DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherData)
            }
           */
            self.delegateScreenWeather?.itISResultRequestLocation(weatherData: weatherData)
        }
        delegateScreenWeather?.itIsResultRequestLocationInCollectionView()
    }
*/
    func requestWeatherLocation(city: String) {
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

    /*
    func requestNewCity(city: String) {
        WeatherService.shared.getWeather(city: city) { (weatherData, error) in
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
    */
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

//
//  protocoleWeatherViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 21/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import UIKit

extension WeatherViewController: AlertDelegate {
 
    func alertError(_ error: NetworkError) {
        DispatchQueue.main.async {
        self.alertVC(title: "Error", message: error.rawValue)
        }
       // performSegue(withIdentifier: Constant.segueSettingWeather, sender: nil)
    }
    
    
}
extension WeatherViewController: PerfomSegueDelegate {
    func perfomSegueIsCalled() {
        performSegue(withIdentifier: Constant.segueSettingWeather, sender: nil)
    }
}

extension WeatherViewController: WeatherViewDelegate {
    func whenButtonSettingIsClicked() {
        performSegue(withIdentifier: Constant.segueSettingWeather, sender: nil)
    }
    
    func whenButtonListIsClicked() {
    }
    
}

extension WeatherViewController: UpdateWeatherViewDelegate {
    func itISResultRequestLocation(weatherData: WeatherData) {
        DispatchQueue.main.async {
            DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherData)
        }
    }
    
    func itIsResultRequestLocationInCollectionView() {
        self.updateCollectionView(view: self.weatherView)
    }
    
    func itIsResultRequest(weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.updateLabelWeatherDomicile(weatherData: weatherData, view: self.weatherView)
        }
    }
    
    
}

extension WeatherViewController: SaveCity {
    func saveCityInRealm(city: String, view: WeatherView) {
        addNewCity(city: city)
        
        weather.requestWeather()
        if weather.requestWeather() == nil {
            return
        } else {
            updateLabelDomicileCity(view: self.weatherView)
        dismiss(animated: true, completion: nil)
    }
}
}

extension WeatherViewController: IsHiddenDelegate {
 
    func viewIsNotHidden() {
        DispatchQueue.main.async {
            //self.weatherView.weatherViewOrCellWeather(view: )
            
            //self.weatherView.toggleActivityIndicator(shown: false)
        }
    }
    
    func viewIsHidden() {
        DispatchQueue.main.async {
            //self.weatherView.weatherViewOrCellWeather(view: self.weatherView)
            //self.weatherView.toggleActivityIndicator(shown: true)
        }
    }
    
    
}


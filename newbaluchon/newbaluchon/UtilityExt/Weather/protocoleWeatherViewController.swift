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
           DBManager.sharedInstance.addOrUpdateDataCityName(weather: weatherData)
            self.updateViewDomicile(city: self.weather.objectsCity[0], view: self.weatherView)
          
        }
    }
    
    
}

extension WeatherViewController: SaveCity {
    
    
    func saveCityInRealm(city: String) {
        //addNewCity(city: city)
        weather.requestNewCityDomicile(city: city)
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherViewController: IsHiddenDelegate {
 
    func viewIsNotHidden() {
        DispatchQueue.main.async {
            //self.weatherView.weatherViewOrCellWeather(view: )
            //self.weatherView.toggleActivityIndicator(shown: true)
            
        }
    }
    
    func viewIsHidden() {
        DispatchQueue.main.async {
            //self.weatherView.weatherViewOrCellWeather(view: self.weatherView)
            //self.weatherView.toggleActivityIndicator(shown: false)
            //self.weatherView.toggleActivityIndicator(shown: true)
            
        }
    }
    
    
}

extension WeatherViewController: WeatherTableViewControllerDelegate {
    func changeWeather(index: IndexPath) {
       let cell = weatherView.collectionView.cellForItem(at: index)
        
        weatherView.collectionView.reloadData()
    }
    
}


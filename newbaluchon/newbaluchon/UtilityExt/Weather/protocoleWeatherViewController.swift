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
        //performSegue(withIdentifier: Constant.segueListeTableView, sender: nil)
    }
    
}

extension WeatherViewController: UpdateWeatherViewDelegate {
    func itIsResultRequestReloadCell(weatherdata: WeatherData, newWeather: WeatherHoliday, index: Int) {
        DispatchQueue.main.async {
            DBManager.sharedInstance.update(newweather1: self.weather.objectsWeathers[index], weatherData: weatherdata)
            self.updateCollectionView(view: self.weatherView)
        }
    }
    
    func itISResultRequestLocation(weatherData: WeatherData) {
        DispatchQueue.main.async {
            DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherData)
            self.updateCollectionView(view: self.weatherView)
        }
    }
    
    func itIsResultRequestLocationInCollectionView() {
        DispatchQueue.main.async {
            self.updateCollectionView(view: self.weatherView)
        }
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
        cityFirst = city
       weather.requestNewCityDomicile(city: city)
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherViewController: IsHiddenDelegate {
    func viewDomicileIsHidden() {
        DispatchQueue.main.async {
            self.weatherView.toggleActivityIndicator(shown: true)
        }
    }
    
    func viewDomicileIsNotHidden() {
        DispatchQueue.main.async {
            self.weatherView.toggleActivityIndicator(shown: false)
        }
    }
    
    func cellIsHidden() {
        DispatchQueue.main.async {
            self.weatherView.toggleActivityIndicatorCollectionView(shown: true)
        }
        
    }
    
    func cellIsNotHidden() {
        DispatchQueue.main.async {
            self.weatherView.toggleActivityIndicatorCollectionView(shown: false)
        }
    }
    
    
}

extension WeatherViewController: WeatherTableViewControllerDelegate {
    func changeWeather(index: IndexPath) {
        weatherView.collectionView.reloadData()
        weatherView.collectionView.scrollToItem(at: index, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        weatherView.pageControl.updateCurrentPageDisplay()
        
        
        
    }
    
}


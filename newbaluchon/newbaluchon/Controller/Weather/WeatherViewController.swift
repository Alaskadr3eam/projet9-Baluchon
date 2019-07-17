//
//  ViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 20/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherView: WeatherView!
    let weather = Weather(weatherServiceSession: WeatherService.shared)
    var cityFirst = String()
    var currentPage = 0
    var previousOffset: CGFloat = 0
    let sectionInsets = UIEdgeInsets(top: 0.0,
                                     left: 0.0,
                                     bottom: 0.0,
                                     right: 0.0)
    let itemsPerRow: CGFloat = 1

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherView.delegateWeahter = self
        weather.delegateScreenWeather = self
        weather.delegateAlertError = self
        weather.delegateViewIsHidden = self
        
        initLocationManager()
        locationHandler()
        weatherView.indicatorActivity.isHidden = true
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.pageControl.hidesForSinglePage = true

        locIsDenied()

    }

    
    override func viewDidAppear(_ animated: Bool) {
         weatherView.collectionView.reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        rotated()
    }
    
    func locIsDenied() {
        if CLLocationManager.authorizationStatus() == .denied || weather.cityLocation == "" {
            weather.createObjectForNoLoc()
        }
        weather.requestWeather()
    }

    func rotated() {
        if UIDevice.current.orientation.isLandscape {
            weatherView.collectionView.reloadData()
        } else {
            weatherView.collectionView.reloadData()
        }
    }
    
    
    func updateViewDomicile(city: CityNameDomicile, view: WeatherView) {
        changeBackgroundWeatherDomicile(city, view)
        view.labelDomicileCity.text = city.name
        if let temperature = city.temperature, let image = city.image{
            view.labelDomicileTemp.text = "\(temperature)°C"
            view.imageWeather.image = UIImage(named: image)
        }
        view.labelDomicileDescription.text = city.desctiptionWeather
        
    }
    
    func realoadRequest(city: String, index: Int, newWeather: WeatherHoliday) {
        if index != 0 {
            weather.requestNewCityReload(city: city, newWeather: newWeather, index: index)
            weatherView.collectionView.reloadData()
        }
    }
    
    func changeBackgroundWeatherDomicile(_ cityData: CityNameDomicile, _ view: WeatherView) {
        let letters = CharacterSet.init(charactersIn: "n")
        let range = cityData.image?.rangeOfCharacter(from: letters)
        if range != nil  {
            view.imageBackground.image = UIImage(named: "ciel nuit")
        } else {
            view.imageBackground.image = UIImage(named: "ciel jour")
        }
    }
    
    func updateLabelDomicileCity(view: WeatherView) {
        view.labelDomicileCity.text = weather.objectsCity[0].name
    }
    
    func updateCollectionView(view: WeatherView) {
        view.collectionView.reloadData()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueSettingWeather {
            if let vcDestination = segue.destination as? WeatherSettingDomicileViewController {
                vcDestination.delegateSaveCity = self
            }
        }
        if segue.identifier == Constant.segueListeTableView {
            if let vcDestination = segue.destination as? WeatherTableViewController {
                vcDestination.delegate = self
            }
        }
    }
    
}

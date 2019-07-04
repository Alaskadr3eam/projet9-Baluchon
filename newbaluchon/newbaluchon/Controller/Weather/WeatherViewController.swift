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
    let weather = Weather()
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
        //DBManager.sharedInstance.deleteAllFromDatabase()

        weatherView.delegateWeahter = self
        weather.delegateScreenWeather = self
        weather.delegatePerformSegue = self
        weather.delegateAlertError = self
        weather.delegateViewIsHidden = self
        
        
        initLocationManager()
        //locationWeatherCity()
        
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.pageControl.hidesForSinglePage = true
        
        //weather.requestWeather()
        
        //weather.cityDomicileItEnter()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        weather.requestWeather()
        locationWeatherCity()
        realoadrequest()
        weatherView.collectionView.reloadData()
       // initLocationManager()
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
       // weather.requestWeather()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    func updateViewDomicile(city: CityNameDomicile, view: WeatherView) {
        changeBackgroundWeatherDomicile(city, view)
        view.labelDomicileCity.text = city.name
        view.labelDomicileTemp.text = "\(city.temperature!)°C"
        view.imageWeather.image = UIImage(named: city.image!)
        view.labelDomicileDescription.text = city.desctiptionWeather
        
    }

    func realoadrequest() {
     for i in 0...weather.objectsWeathers.count - 1 {
            weather.requestNewCityReload(city: weather.objectsWeathers[i].name!, newWeather: weather.objectsWeathers[i], index: i)
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
/*
    func addNewCity(city: String) {
        weather.addNewCity(city: city)
        //DBManager.sharedInstance.addOrUpdateDataFirst(city: city)
    }
*/
    
    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constant.segueSettingWeather {
        if let vcDestination = segue.destination as? WeatherSettingDomicileViewController1 {
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

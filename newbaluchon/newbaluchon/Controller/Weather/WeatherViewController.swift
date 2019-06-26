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
        locationWeatherCity()
        
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.pageControl.hidesForSinglePage = true
        weather.requestWeather()
        //weather.cityDomicileItEnter()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        //weather.requestWeather()
        
        weatherView.collectionView.reloadData()
       // initLocationManager()
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        //weather.requestWeather()
    }
 /*
    @IBAction func telechargeCity(_ sender: UIBarButtonItem) {
        weather.requestWeatherCity()
    }
 */
/*
    @IBAction func saveToWeatherViewController (segue: UIStoryboardSegue, view: WeatherView) {
        let settingViewController = segue.source as! WeatherSettingDomicileViewController
        if settingViewController.cityTextField.text!.isEmpty == true {
            
            return
        } else {
            let cityDomicile = settingViewController.cityTextField.text!
            addNewCity(city: cityDomicile)
            view.labelDomicileCity.text = weather.objectsCity[0].name
            //dismiss(animated: true, completion: nil)
        }
    }
 */
    /*
    @IBAction func anulateToWeatherViewController (segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    */
    /*
    @IBAction func annulateAddHolidayToWeatherTableViewController (segue: UIStoryboardSegue) {
        //let addCityWeatherViewController = segue.source as! AddCityWeatherUIViewController
        dismiss(animated: true, completion: nil)
    }
*/
    

    func updateLabelWeatherDomicile(weatherData: WeatherData, view: WeatherView) {
        view.labelDomicileCity.text = weatherData.name
        view.labelDomicileTemp.text = "\(weatherData.main.temp)°C"
        view.imageWeather.image = UIImage(named: weatherData.weather[0].icon)
        view.labelDomicileDescription.text = weatherData.weather[0].description
    }

    func updateLabelDomicileCity(view: WeatherView) {
        view.labelDomicileCity.text = weather.objectsCity[0].name
    }

    func updateCollectionView(view: WeatherView) {
        view.collectionView.reloadData()
    }

    func addNewCity(city: String) {
        weather.addNewCity(city: city)
        //DBManager.sharedInstance.addOrUpdateDataFirst(city: city)
    }

    
    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == Constant.segueSettingWeather {
 if let vcDestination = segue.destination as? WeatherSettingDomicileViewController {
 vcDestination.delegateSaveCity = self
 }
 }
 }

}
/*
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
        updateLabelDomicileCity(view: self.weatherView)
        weather.requestWeather()
        dismiss(animated: true, completion: nil)
    }
}
*/
/*
extension WeatherViewController: CLLocationManagerDelegate {
    
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationWeatherCity() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Autorisation")
                let lat = locationManager.location?.coordinate.latitude
                let long = locationManager.location?.coordinate.longitude
                let location = CLLocation(latitude: lat!, longitude: long!)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                    if error != nil {
                        return
                    } else if let country = placemarks?.first?.country, let city = placemarks?.first?.locality {
                        print(city)
                        print(country)
                        self.weather.requestWeatherLocation(city: city, country: country)
                    }
                })
                break
            case .notDetermined, .restricted, .denied:
                print("Error: Either Not Determined, Restricted, or Denied.")
                break
            }
        }
    }
}
    

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return weather.objectsWeathers.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReuseIdentifier", for: indexPath) as! WeatherCollectionViewCell
            weatherView.pageControl.numberOfPages = weather.objectsWeathers.count
            cell.labelCityName.text = weather.objectsWeathers[indexPath.row].name
            cell.labelTemp.text = weather.objectsWeathers[indexPath.row].temperature
            cell.labelDescription.text = weather.objectsWeathers[indexPath.row].descriptionWeather
            cell.imageWeather.image = UIImage(named: weather.objectsWeathers[indexPath.row].image!)
            return cell
        }
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth = scrollView.frame.width
            self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
            weatherView.pageControl.currentPage = self.currentPage
        }
    }
    
 
    /*
     let newWeatherLocation = self.objectsWeathers.first
     DispatchQueue(label: "com.example.myApp.bg").async {
     //let realm = try! Realm()
     guard let person = realm.resolve(newWeatherLocation) else {
     return // person was deleted
     }
     try! realm.write {
     weatherLocation.name = weatherData.name
     weatherLocation.temperature = String(weatherData.main.temp)
     weatherLocation.descriptionWeather = weatherData.weather[0].description
     weatherLocation.image = weatherData.weather[0].icon
     }
     }
     */
*/

//
//  WeatherViewController.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class WeatherViewController: UIViewController, SaveCity {
    func saveCityInRealm(city: String) {
        addNewCity(city: city)
        labelDomicileCity.text = objectsCity[0].name
        dismiss(animated: true, completion: nil)
    }
    

    
    var objectsWeathers = DBManager.sharedInstance.getDataFromDBWeatherHoliday()
    var objectsCity = DBManager.sharedInstance.getDataFromDBCityNameDomicile()
    var objectCity2: Results<CityNameDomicile>!

    @IBOutlet weak var labelDomicileCity: UILabel!
    @IBOutlet weak var labelDomicileTemp: UILabel!
    @IBOutlet weak var labelDomicileDescription: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentPage = 0
    

    

    //var dataWeatherHoliday = [WeatherHoliday]()

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DBManager.self
        
        //DBManager.sharedInstance.deleteAllFromDatabase()
        
        cityDomicileItEnter()
    
        initLocationManager()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageControl.hidesForSinglePage = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //code
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        initLocationManager()
        //labelDomicileCity.text = UserDefaults.standard.string(forKey: "cityName") ?? ""
        locationWeatherCity()
        requestWeather()
    }

    func cityDomicileItEnter() {
        let domcile = CityNameDomicile()
        domcile.name = ""
        DBManager.sharedInstance.addDataCityNameDomicile(object: domcile)
        if objectsCity.count == 1 {
            performSegue(withIdentifier: "enterCity", sender: nil)
        } else {
            return
        }
        /*
        let domcile = CityNameDomicile()
        domcile.name = "Paris"
        DBManager.sharedInstance.addDataCityNameDomicile(object: domcile)
        if objectsCity.first?.name == "Paris" {
            performSegue(withIdentifier: "enterCity", sender: nil)
        }
 */
    }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterCity" {
            if let vcDestination = segue.destination as? WeatherSettingDomicileViewController {
                vcDestination.delegateSaveCity = self
            }
        }
    }


   @IBAction func saveToWeatherViewController (segue: UIStoryboardSegue) {
        let settingViewController = segue.source as! WeatherSettingDomicileViewController
        if settingViewController.cityTextField.text!.isEmpty == true {
            
           return
        } else {
            let cityDomicile = settingViewController.cityTextField.text!
            addNewCity(city: cityDomicile)
            labelDomicileCity.text = objectsCity[0].name
            //dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func anulateToWeatherViewController (segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func annulateAddHolidayToWeatherTableViewController (segue: UIStoryboardSegue) {
        //let addCityWeatherViewController = segue.source as! AddCityWeatherUIViewController
        dismiss(animated: true, completion: nil)
    }

    private func addNewCity(city: String) {
        DBManager.sharedInstance.addOrUpdateDataFirst(city: city)
    }

     func requestWeather() {
        WeatherService.shared.getWeather(city: objectsCity[0].name!) { (weatherData, error) in
            if let error = error {
                //alert
                return
            }
            guard let weatherData = weatherData else {
                return
            }
            DispatchQueue.main.async {
                self.updateLabelWeatherDomicile(weatherData: weatherData)
            }
        }
    }

    private func updateLabelWeatherDomicile(weatherData: WeatherData) {
        self.labelDomicileCity.text = weatherData.name
        self.labelDomicileTemp.text = "\(weatherData.main.temp)°C"
        self.imageWeather.image = UIImage(named: weatherData.weather[0].icon)
        self.labelDomicileDescription.text = weatherData.weather[0].description
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectsWeathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReuseIdentifier", for: indexPath) as! WeatherCollectionViewCell
            self.pageControl.numberOfPages = objectsWeathers.count
            cell.labelCityName.text = objectsWeathers[indexPath.row].name
            cell.labelTemp.text = objectsWeathers[indexPath.row].temperature
            cell.labelDescription.text = objectsWeathers[indexPath.row].descriptionWeather
            cell.imageWeather.image = UIImage(named: objectsWeathers[indexPath.row].image!)
            return cell
        }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageControl.currentPage = self.currentPage
    }
}

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
                            self.requestWeatherLocation(city: city, country: country)
                            }
                        })
                    break
                case .notDetermined, .restricted, .denied:
                    print("Error: Either Not Determined, Restricted, or Denied.")
                    break
                }
            }
        }

    func updateWeatherLocation(city: String, country: String) {
        if objectsWeathers.count == 0 {
            requestWeatherLocation(city: city, country: country)
        } else {
            
        }
    }
    

    
    func requestWeatherLocation(city: String, country: String) {
        
        WeatherService.shared.getWeatherLocation(city: "\(city),\(country)") { (weatherData, error) in
            if let error = error {
                //alert
                return
            }
            guard let weatherData = weatherData else {
                return
            }
             DispatchQueue.main.async {
            DBManager.sharedInstance.addOrUpdateDataWeatherHolidayFirst(weather: weatherData)
            }
             /*   //let weatherLocation = WeatherHoliday()
                weatherLocation.name = weatherData.name
                weatherLocation.temperature = String(weatherData.main.temp)
                weatherLocation.descriptionWeather = weatherData.weather[0].description
                weatherLocation.image = weatherData.weather[0].icon
            DispatchQueue.main.async {
                if self.objectsWeathers.count == 0 {
                try! self.realm.write {
                    self.realm.add(weatherLocation)
                }
                } else {
                    if let newWeatherLocation = self.objectsWeathers.first {
                        try! self.realm.write {
                            newWeatherLocation.name = weatherData.name
                            newWeatherLocation.temperature = String(weatherData.main.temp)
                            newWeatherLocation.descriptionWeather = weatherData.weather[0].description
                            newWeatherLocation.image = weatherData.weather[0].icon
                            }
                    }
                    
                }
            }
 */
                
            
        }
        self.collectionView.reloadData()
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
    func updateCell() {
        locationWeatherCity()
    }
}


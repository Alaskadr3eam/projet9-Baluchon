//
//  WeatherViewController.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

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
    
        cityDomicileItEnter()
    
        labelDomicileCity.text = UserDefaults.standard.string(forKey: "cityName") ?? ""
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
        //initLocationManager()
        labelDomicileCity.text = UserDefaults.standard.string(forKey: "cityName") ?? ""
        locationWeatherCity()
        requestWeather()
    }

    func cityDomicileItEnter() {
        if UserDefaults.standard.string(forKey: "cityName") ?? "" == nil || UserDefaults.standard.string(forKey: "cityName") ?? "" == "" {
            performSegue(withIdentifier: "enterCity", sender: nil)
        }
    }

   @IBAction func saveToWeatherViewController (segue: UIStoryboardSegue) {
        let settingViewController = segue.source as! WeatherSettingDomicileViewController
        if settingViewController.cityTextField.text!.isEmpty != true {
            let cityDomicile = settingViewController.cityTextField.text!
            UserDefaults.standard.set(cityDomicile, forKey: "cityName")
            labelDomicileCity.text = cityDomicile
        } else {
            // alert ( guard )
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
     func requestWeather() {
        WeatherService.shared.getWeather(city: labelDomicileCity.text!) { (weatherData, error) in
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
        return Constant.dataWeatherHoliday.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReuseIdentifier", for: indexPath) as! WeatherCollectionViewCell
            self.pageControl.numberOfPages = Constant.dataWeatherHoliday.count
            cell.labelCityName.text = Constant.dataWeatherHoliday[indexPath.row].name
            cell.labelTemp.text = "\(Constant.dataWeatherHoliday[indexPath.row].temperature)°C"
            cell.labelDescription.text = Constant.dataWeatherHoliday[indexPath.row].description
            cell.imageWeather.image = UIImage(named: Constant.dataWeatherHoliday[indexPath.row].image)
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
                let weatherLocation = WeatherHoliday()
                weatherLocation.name = weatherData.name
                weatherLocation.temperature = weatherData.main.temp
                weatherLocation.description = weatherData.weather[0].description
                weatherLocation.image = weatherData.weather[0].icon
                if Constant.dataWeatherHoliday.count == 0 {
                    Constant.dataWeatherHoliday.append(weatherLocation)
                } else {
                    Constant.dataWeatherHoliday[0] = weatherLocation
                }
                self.collectionView.reloadData()
            }
        }
    }

    func updateCell() {
        locationWeatherCity()
    }
}

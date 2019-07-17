//
//  ExtWeatherViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 21/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationHandler()
        
    }
    
    func initLocationManager() {
        locationManager.delegate = self
    }
    
    func locationHandler() {
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if (CLLocationManager.authorizationStatus() == .denied) {
                DispatchQueue.main.async {
                    if self.weather.objectsCity.count == 0 {
                        self.alertVC(title: "Attention", message: "Location Refusé. Vous pouvez rentrer votre ville d'origine manuellement(en haut à droite). Vous pouvez aussi rajouter des villes de vacance (en bas à droite).")
                    } else {
                        self.alertVC(title: "Attention", message: "Location non trouvé. Vous pouvez aussi rajouter des villes de vacance (en bas à droite)1.")
                    }
                }
            } else if (CLLocationManager.authorizationStatus() == .authorizedAlways || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse)) {
                let lat = locationManager.location?.coordinate.latitude
                let long = locationManager.location?.coordinate.longitude
                guard lat != nil, long != nil else {
                    DispatchQueue.main.async {
                    if self.weather.objectsCity.count == 0 {
                        self.alertVC(title: "Attention", message: "Location non trouvé. Vous pouvez rentrer votre ville d'origine manuellement(en haut à droite). Vous pouvez aussi rajouter des villes de vacance (en bas à droite).")
                    } else {
                        self.alertVC(title: "Attention", message: "Location non trouvé. Vous pouvez aussi rajouter des villes de vacance (en bas à droite).")
                    }
                    }
                    return
                }
                if let lat = lat, let long = long {
                    let location = CLLocation(latitude: lat, longitude: long)
                    CLGeocoder().reverseGeocodeLocation(location, completionHandler: { [weak self] (placemarks, error) in
                        guard let self = self else {
                            return
                        }
                        guard error == nil else {
                            self.alertVC(title: "Erreur01", message: "Probleme de localisation")
                            return
                        }
                        guard let country = placemarks?.first?.country, let city = placemarks?.first?.locality else {
                            self.alertVC(title: "Erreur02", message: "Probleme localisation")
                            return
                        }
                        self.weather.cityLocation = city
                        self.weather.countryLocation = country
                    })
                } else {
                    locationHandler()
                }
            } else if (CLLocationManager.authorizationStatus() == .notDetermined){
                alertVC(title: "Error", message: "Either Not Determined")
                
            } else /*if (CLLocationManager.authorizationStatus() == .never)*/ { }
        } else {
            weather.requestWeather()
            
        }
    }
    
}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.objectsWeathers.count
    }
    
    func changeBackground(index: Int, cell: WeatherCollectionViewCell) {
        let letters = CharacterSet.init(charactersIn: "n")
        let range = weather.objectsWeathers[index].image?.rangeOfCharacter(from: letters)
        if range != nil  {
            cell.imageBackgound.image = UIImage(named: "ciel nuit")
        } else {
            cell.imageBackgound.image = UIImage(named: "ciel jour")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReuseIdentifier", for: indexPath) as! WeatherCollectionViewCell
        weatherView.collectionView.contentMode = .scaleAspectFit
        weatherView.pageControl.numberOfPages = weather.objectsWeathers.count
        cell.imageWeather.contentMode = .scaleAspectFit
        cell.labelCityName.text = weather.objectsWeathers[indexPath.row].name
        if let temperature = weather.objectsWeathers[indexPath.row].temperature {
        cell.labelTemp.text = ("\(temperature)°C")
        }
        cell.labelDescription.text = weather.objectsWeathers[indexPath.row].descriptionWeather
        if let image = weather.objectsWeathers[indexPath.row].image {
        cell.imageWeather.image = UIImage(named: image)
        }
        changeBackground(index: indexPath.row, cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        weatherView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        weatherView.pageControl.currentPage = self.currentPage
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToNearestCell(weatherView.collectionView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = weatherView.pageControl.currentPage
        if index == 0 {
            if CLLocationManager.authorizationStatus() == .denied || weather.cityLocation != ""{
                locationHandler()
             //   weather.requestWeather()
            }
            weather.requestWeather()
        } else {
            if let city = weather.objectsWeathers[index].name {
                realoadRequest(city: city, index: index, newWeather: weather.objectsWeathers[index])
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNearestCell(weatherView.collectionView)
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDeviceOrientation.landscapeRight.isLandscape {
            let availableWidth = weatherView.viewCollectionView.frame.width
            let widthPerItem = availableWidth / itemsPerRow
            
            let availableHeight = weatherView.viewCollectionView.frame.height
            let heigthPerItem = availableHeight / itemsPerRow
            
            return CGSize(width: widthPerItem, height: heigthPerItem)
        } else if UIDeviceOrientation.portrait.isPortrait {
            let availableWidth = weatherView.viewCollectionView.frame.width
            let widthPerItem = availableWidth / itemsPerRow
            
            let availableHeight = weatherView.viewCollectionView.frame.height
            let heigthPerItem = availableHeight / itemsPerRow
            
            return CGSize(width: widthPerItem, height: heigthPerItem)
        }
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    func snapToNearestCell(_ collectionView: UICollectionView) {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            
            let itemWithSpaceWidth = weatherView.collectionLayoutFlow.itemSize.width + weatherView.collectionLayoutFlow.minimumLineSpacing
            let itemWidth = weatherView.collectionLayoutFlow.itemSize.width
            
            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }
    
}

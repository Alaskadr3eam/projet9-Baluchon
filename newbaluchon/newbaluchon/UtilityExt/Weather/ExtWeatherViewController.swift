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
                        self.weather.cityLocation = city
                        self.weather.countryLocation = country
                        print(city)
                        print(country)
                        self.weather.requestWeather()
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
       // weather.requestNewCityReload(city: weather.objectsWeathers[indexPath.row].name, newWeather: weather.objectsWeathers[indexPath.row], index: indexPath.row)
      //  realoadRequest(city: weather.objectsWeathers[indexPath.row].name!, index: indexPath.row, newWeather: weather.objectsWeathers[indexPath.row])
        cell.imageWeather.contentMode = .scaleAspectFit
        cell.labelCityName.text = weather.objectsWeathers[indexPath.row].name
        cell.labelTemp.text = ("\(weather.objectsWeathers[indexPath.row].temperature!)°C")
        cell.labelDescription.text = weather.objectsWeathers[indexPath.row].descriptionWeather
        cell.imageWeather.image = UIImage(named: weather.objectsWeathers[indexPath.row].image!)
        changeBackground(index: indexPath.row, cell: cell)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print(indexPath.row)
       // realoadRequest(city: weather.objectsWeathers[indexPath.row].name!, index: indexPath.row, newWeather: weather.objectsWeathers[indexPath.row])
    }
    
    


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        weatherView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        weatherView.pageControl.currentPage = self.currentPage
        //let index = weatherView.pageControl.currentPage
        //realoadRequest(city: weather.objectsWeathers[index].name!, index: index, newWeather: weather.objectsWeathers[index])
       /* weather.requestNewCityReload(city: weather.objectsWeathers[currentPage].name!, newWeather: weather.objectsWeathers[currentPage], index: currentPage)
        weatherView.collectionView.reloadData()*/
       
        
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToNearestCell(weatherView.collectionView)
        //print(weatherView.pageControl.currentPage)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = weatherView.pageControl.currentPage
       // weatherView.viewCollectionView.isHidden = true
        realoadRequest(city: weather.objectsWeathers[index].name!, index: index, newWeather: weather.objectsWeathers[index])
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
        
        return CGSize(width: widthPerItem, height: widthPerItem)
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
            
          //  realoadRequest(city: weather.objectsWeathers[i].name!, index: i, newWeather: weather.objectsWeathers[i])
            
            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }

    
/*
extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToCenter()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapToCenter()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        weatherView.pageControl.currentPage = self.currentPage
        
    }
 */
}

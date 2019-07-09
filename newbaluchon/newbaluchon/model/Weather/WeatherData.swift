//
//  Weather.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import RealmSwift

struct WeatherData: Decodable {
    var weather: [Weathers]
    var main: Main
    var name: String
}

struct Weathers: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var temp_min: Double
    var temp_max: Double
}

struct WeatherDataLocation {
    var name: String
    var country: String
}

struct WeatherDataCity: Codable {
    var city: [City]
}

struct City: Codable {
    var id: Int
    var name: String
    var country: String
}

class WeatherHoliday: Object {
    @objc dynamic var name: String?
    @objc dynamic var temperature: String?
    @objc dynamic var descriptionWeather: String?
    @objc dynamic var image: String?
}

class CityNameDomicile: Object {
    @objc dynamic var name: String?
    @objc dynamic var temperature: String?
    @objc dynamic var desctiptionWeather: String?
    @objc dynamic var image: String?
}


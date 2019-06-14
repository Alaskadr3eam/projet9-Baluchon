//
//  Weather.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

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

class WeatherHoliday {
    var name = ""
    var temperature = 0.0
    var description = ""
    var image = ""
}

/*
class WeatherDomicile: Object {
    @objc dynamic var name = ""
    @objc dynamic var temperature = ""
    @objc dynamic var description = ""
    @objc dynamic var image: Data? = nil
}

class WeatherHoliday: Object {
    @objc dynamic var name = ""
    @objc dynamic var temperature = ""
    @objc dynamic var description = ""
    @objc dynamic var image: Data? = nil
}

class WeatherLocation: Object {
    @objc dynamic var name = ""
    @objc dynamic var temperature = ""
    @objc dynamic var description = ""
    @objc dynamic var image: Data? = nil
}
*/

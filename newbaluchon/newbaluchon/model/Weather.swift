//
//  Weather.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var coordinate: Coordinate
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Double
    var id: Double
    var name: String
    var cod: Int
    
}
struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var desciption: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var temp_min: Double
    var temp_max: Double
}

struct Wind: Codable {
    var speed: Int
}

struct Clouds: Codable {
    var all: Int
}

struct Sys: Codable {
    var type: Int
    var id: Int
    var message: Double
    var country: String
    var sunrise: Double
    var sunset: Int
}


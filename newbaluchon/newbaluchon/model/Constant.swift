//
//  Constant.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
struct Constant {
    // MARK: - PROPERTIES WEATHER
    //key: 2567298816d0d1f85b5a7edfdc58aa63,"aa9e109ce2968dabc49a4e7bda426532"
    static var weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    static var apiKeyWeather = "2567298816d0d1f85b5a7edfdc58aa63"
    static var unit = "metric"
    static var lang = "fr"
    static var dataWeatherHoliday = [WeatherHoliday]()    //var param = ["q": String,"APPID":String,"units":"metric","lang":"fr"]

    // MARK: - properties translate
    static var translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    static var apiKeyTranslate = "AIzaSyDX07xWgK_IQRN3wXHFBopwycC9AzachOU"

    
}

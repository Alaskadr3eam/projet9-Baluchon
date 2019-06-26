//
//  WeatherService.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class WeatherService {

    //var weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    //var weatherUrl2 = URL(string: "api.openweathermap.org/data/2.5/weather?APPID=2567298816d0d1f85b5a7edfdc58aa63&units=metric&lang=fr&q=paris")!
    
    static var shared = WeatherService()
    
   private init () {}

    var task: URLSessionDataTask?
    
    private var arguments: [String: String] =
        ["q": String(),
         "APPID": Constant.apiKeyWeather,
         "units": Constant.unit
        ]
    
    func getWeather(q: String, completionHandler: @escaping (WeatherData?,NetworkError?) -> Void) {
        arguments["q"] = q
        /*
        guard let request = ServiceCreateRequest.createRequest(url: Constant.weatherUrl, arguments: arguments) else {
            completionHandler(nil,NetworkError.invalidRequestURL)
            return
        }*/
        var request = ServiceCreateRequest.createRequest(url: Constant.weatherUrl, arguments: arguments)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                print("errorDataWeather")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                print("error response")
                return
            }
            guard let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                print("error responseJSON")
                return
            }
            
            print(weatherData.name)
            print(weatherData.main.temp)
            print(weatherData.weather[0].icon)
            print(weatherData.weather[0].description)
            
            completionHandler(weatherData, nil)
        }
        task?.resume()
    }
    /*
    //var request: URLRequest!
   
    func getWeather(city: String, completionHandler: @escaping (WeatherData?,NetworkError?) -> Void) {
        var request = ServiceCreateRequest.createWeatherRequest(city: city)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                print("errorDataWeather")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                print("error response")
                return 
            }
            guard let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                print("error responseJSON")
                return
            }
            
            print(weatherData.name)
            print(weatherData.main.temp)
            print(weatherData.weather[0].icon)
            print(weatherData.weather[0].description)
         
            completionHandler(weatherData, nil)
        }
        task?.resume()
    }

    func getWeatherLocation(city: String, completionHandler: @escaping (WeatherData?,NetworkError?) -> Void) {
        var request = ServiceCreateRequest.createWeatherRequest(city: city)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                print("errorDataLocation")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                print("error response")
                return
            }
            guard let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                print("error responseJSON")
                return
            }
            print(weatherData.name)
            print(weatherData.main.temp)
            print(weatherData.weather[0].icon)
            print(weatherData.weather[0].description)
            
            completionHandler(weatherData, nil)
        }
        task?.resume()
    }

    func getWeatherForCity(completionHandler: @escaping (WeatherDataCity?,NetworkError?) -> Void) {
        var request = ServiceCreateRequest.createWeatherRequestForCity()
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                print("errorDataCity")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                print("error response")
                return
            }
            guard let weatherDataCity = try? JSONDecoder().decode(WeatherDataCity.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                print("error responseJSONCity")
                return
            }
 
            completionHandler(weatherDataCity, nil)
        }
        task?.resume()
    }
    /*
    func createWeatherRequest(city: String) {
    
        var urlComponents = URLComponents(url: Constant.weatherUrl, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = ["q": city,"APPID":Constant.apiKeyWeather,"units":Constant.unit,"lang":Constant.lang]
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        request = URLRequest(url: url!)
    }
*/*/
}

//
//  WeatherService.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class WeatherService {
    
    static var shared = WeatherService()
    
    private var weatherSession = URLSession(configuration: .default)
    
    init(weatherSession: URLSession) {
       
        self.weatherSession = weatherSession
    }
    
    private init () {}
    
    var task: URLSessionDataTask?
    
    private var arguments: [String: String] =
        ["q": String(),
         "APPID": Constant.apiKeyWeather,
         "units": Constant.unit,
            "lang": Constant.lang
    ]
    
    func getWeather(q: String, completionHandler: @escaping (WeatherData?,NetworkError?) -> Void) {
        arguments["q"] = q
        guard var request = ServiceCreateRequest.createRequest(url: Constant.weatherUrl, arguments: arguments) else { return }
        request.httpMethod = "GET"
        task?.cancel()
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                return
            }
            guard let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                return
            }
            completionHandler(weatherData, nil)
        }
        task?.resume()
    }
    
}

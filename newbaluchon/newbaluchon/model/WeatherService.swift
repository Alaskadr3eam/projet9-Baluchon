//
//  WeatherService.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class WeatherService {

    var weatherUrlString = "api.openweathermap.org/data/2.5/weather"
    
    static var shared = WeatherService()
    
   private init () {}

    var task: URLSessionDataTask?
    
    var requestTransition: URLRequest!
    
    /*
     func getTranslate(q: String, source: String, target: String) {
     var request = createTranslateRequest(q: q, source: source, target: target)
     request.httpMethod = "GET"
     let session = URLSession(configuration: .default)
     task?.cancel()
     task = session.dataTask(with: request) { (data, response, error) in
     guard let data = data, error == nil else {
     print("error1")
     return
     }
     
     guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
     print("error200")
     return
     }
     
     guard let responseJSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] else {
     print("error Reponse")
     return
     }
     if let data = responseJSON!["data"] as? [String: Any], let translations = data["translations"] as? [[String: Any]] {
     var allTranslations = [String]()
     for translation in translations {
     if let translatedText = translation["translatedText"] as? String {
     allTranslations.append(translatedText)
     }
     }
     Translate.textTranslated = allTranslations[0]
     print(allTranslations)
     }
     //print(allTranslations[0])
     
     print(responseJSON)
     
     }
     task?.resume()
     }
     */
    var url = URL(string: "api.openweathermap.org/data/2.5/weather?APPID=2567298816d0d1f85b5a7edfdc58aa63&units=metric&lang=fr&q=paris")!
    func getWeather(completionHandler: @escaping (WeatherData?,Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                print("errorData")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, error)
                print("error response")
                return
            }
            
            guard let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                completionHandler(nil, error)
                print("error responseJSON")
                return
            }
            print(weatherData)
            completionHandler(weatherData, nil)
        }
        task?.resume()
    }
    
    /*
     private func createBodyRequest(q: String, source: String, target: String) -> String {
     let body = "key=AIzaSyDX07xWgK_IQRN3wXHFBopwycC9AzachOU&q=\(q)&source=\(source)&target=\(target)"
     return body
     }
     private func createTranslateRequest(q: String, source: String, target: String) -> URLRequest {
     var request = URLRequest(url: translateUrl)
     request.httpMethod = "GET"
     
     let body = createBodyRequest(q: q, source: source, target: target)
     request.httpBody = body.data(using: .utf8)
     
     return request
     }
     */
    func createTranslateRequest(city: String) {
        let url = weatherUrlString
        let key = "2567298816d0d1f85b5a7edfdc58aa63"
        var items = [URLQueryItem]()
        var myURL = URLComponents(string: url)
        let param = ["q": city,"APPID":key,"units":"metric","lang":"fr"]
        for (key,value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        myURL?.queryItems = items
        let requestMutable =  URLRequest(url: (myURL?.url)!)
        requestTransition = requestMutable
    }

}

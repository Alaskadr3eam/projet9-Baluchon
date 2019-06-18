//
//  ServiceCreateRequest.swift
//  newbaluchon
//
//  Created by Fiona on 11/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
struct ServiceCreateRequest {
    // MARK: - Request WEATHER
    static func createWeatherRequest(city: String) -> URLRequest {
        
        var urlComponents = URLComponents(url: Constant.weatherUrl, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = ["q": city,"APPID":Constant.apiKeyWeather,"units":Constant.unit,"lang":Constant.lang]
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        let request = URLRequest(url: url!)
        return request
    }

    // MARK: - Request Translate
    static func createTranslateRequest(text: String, source: String, target: String) -> URLRequest {
        
        var urlComponents = URLComponents(url: Constant.translateUrl, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = ["q": text,"key":Constant.apiKeyTranslate,"source":source,"target":target]
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        let request = URLRequest(url: url!)
        return request
    }

    // MARK: - Request Money
    static func createMoneyRequest() -> URLRequest {
        
        var urlComponents = URLComponents(url: Constant.moneyUrl, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = ["access_key":Constant.apiKeyMoney]
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        let request = URLRequest(url: url!)
        return request
    }

    // MARK: - Request Devise
    static func createDeviseRequest() -> URLRequest {
        
        var urlComponents = URLComponents(url: Constant.deviseUrl, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = ["access_key":Constant.apiKeyMoney]
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        let request = URLRequest(url: url!)
        return request
    }
    
}

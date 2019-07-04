//
//  TranslateService.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class TranslateService {

    static var shared = TranslateService()

    private var translateSession = URLSession(configuration: .default)

    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    private init () {}

    private var task: URLSessionDataTask?

    var arguments: [String: String] =
        ["q": String(),"key":Constant.apiKeyTranslate,"source":String(),"target":String()]

    
    func getTranslate(text: String, source: String, target: String, completionHandler: @escaping (TranslationData?,NetworkError?) -> Void) {
        arguments["q"] = text
        arguments["source"] = source
        arguments["target"] = target
        var request = ServiceCreateRequest.createRequest(url: Constant.translateUrl, arguments: arguments)
        request.httpMethod = "GET"
       // let session = URLSession(configuration: .default)
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
           guard let data = data, error == nil else {
            completionHandler(nil, NetworkError.emptyData)
                print("errorData")
                return
            }
 print(data)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                print("error response")
                return
            }
     print(response)
            
            guard let translationData = try? JSONDecoder().decode(TranslationData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                    print("error responseJSON")
                    return
            }
           
            //print(self.translatedText)
            print(translationData.data.translations[0].translatedText)
            completionHandler(translationData, nil)
        }
            task?.resume()
        }
/*
    func createTranslateRequest(text: String, source: String, target: String) {

        var urlComponents = URLComponents(url: Constant.translateUrl, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = ["q": text,"key":Constant.apiKeyTranslate,"source":source,"target":target]
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        request = URLRequest(url: url!)
    }
*/
    
}

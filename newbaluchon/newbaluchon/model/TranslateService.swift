//
//  TranslateService.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class TranslateService {
    
    
   // private var translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    
    private var task: URLSessionDataTask?
    static var shared = TranslateService()
    
    //var request: URLRequest!
    
 //   var translatedText = ""
    
    private init () {}
    
    func getTranslate(text: String, source: String, target: String, completionHandler: @escaping (TranslationData?,Error?) -> Void) {
        var request = ServiceCreateRequest.createTranslateRequest(text: text, source: source, target: target)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
           guard let data = data, error == nil else {
            completionHandler(nil, error)
                print("errorData")
                return
            }
 print(data)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, error)
                print("error response")
                return
            }
     print(response)
            
            guard let translationData = try? JSONDecoder().decode(TranslationData.self, from: data) else {
                completionHandler(nil, error)
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

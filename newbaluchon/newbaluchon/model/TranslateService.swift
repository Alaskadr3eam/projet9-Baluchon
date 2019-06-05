//
//  TranslateService.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
class TranslateService {
    
    private var translateUrlString = "https://translation.googleapis.com/language/translate/v2"
    
    private var task: URLSessionDataTask?
    static var shared = TranslateService()
    
    var requestTransition: URLRequest!
    
    var translatedText = ""
    
    private init () {}
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
    
    func getTranslate(completionHandler: @escaping (TranslationData?,Error?) -> Void) {
        var request = requestTransition
        request!.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request!) { (data, response, error) in
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
            /*
            guard let translationData = try? JSONDecoder().decode(TranslationData.self, from: data) else {
                completionHandler(nil, error)
                    print("error responseJSON")
                    return
            }*/
            guard let responseJSON = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] else {
                completionHandler(nil, error)
                print("error Reponse")
                return
            }
            if let data = responseJSON!["data"] as? [String: Any], let translations = data["translations"] as? [[String: Any]] {
                var allTranslations = [String]()
                for reponse in translations {
                    if let translatedText = reponse["translatedText"] as? String {
                        allTranslations.append(translatedText)
                    }
                    
                }
                self.translatedText = allTranslations[0]
            }
 
            print(self.translatedText)
            
            completionHandler(nil, nil)
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
    func createTranslateRequest(text: String, source: String, target: String) {
        /*
        let url = translateUrlString
        let key = "AIzaSyDX07xWgK_IQRN3wXHFBopwycC9AzachOU"
        var items = [URLQueryItem]()
        var myURL = URLComponents(string: url)
        let param = ["q": text,"key":key,"source":source,"target":target]
        for (key,value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        myURL?.queryItems = items
        let requestMutable =  URLRequest(url: (myURL?.url)!)
        requestTransition = requestMutable
 */
        
        translateUrlString = ""
        translateUrlString = "https://translation.googleapis.com/language/translate/v2?"
        let urlEncodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "key=AIzaSyDX07xWgK_IQRN3wXHFBopwycC9AzachOU&q=\(urlEncodedText!)&source=\(source)&target=\(target)&format=text"
        translateUrlString += url
        let translateUrl = URL(string: translateUrlString)!
        let requestMutable = URLRequest(url: translateUrl)
        requestTransition = requestMutable 
 
    }

    
}

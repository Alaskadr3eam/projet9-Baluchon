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
        guard var request = ServiceCreateRequest.createRequest(url: Constant.translateUrl, arguments: arguments) else { return }
        request.httpMethod = "GET"
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                return
            }
            guard let translationData = try? JSONDecoder().decode(TranslationData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                return
            }
            completionHandler(translationData, nil)
        }
        task?.resume()
    }
}

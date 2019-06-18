//
//  MoneyService.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

class MoneyService {

    private var task: URLSessionDataTask?
    static var shared = MoneyService()
    

    private init () {}

    func getMoneyCurrent(completionHandler: @escaping(MoneyData?,Error?) -> Void) {
        var request = ServiceCreateRequest.createMoneyRequest()
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
            
            guard let moneyData = try? JSONDecoder().decode(MoneyData.self, from: data) else {
                completionHandler(nil, error)
                print("error responseJSON")
                return
            }
            
            //print(self.translatedText)
            print(moneyData.rate[0])
            completionHandler(moneyData, nil)
        }
        task?.resume()
    }
    
}

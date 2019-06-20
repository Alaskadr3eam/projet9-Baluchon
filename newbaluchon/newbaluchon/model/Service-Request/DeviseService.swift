//
//  DeviseService.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

class DeviseService {
    
    private var task: URLSessionDataTask?
    static var shared = DeviseService()
    
    
    private init () {}
    
    func getMoneyCurrent(completionHandler: @escaping(DeviseData?,Error?) -> Void) {
        var request = ServiceCreateRequest.createDeviseRequest()
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
            
            guard let deviseData = try? JSONDecoder().decode(DeviseData.self, from: data) else {
                completionHandler(nil, error)
                print("error responseJSON")
                return
            }
            
            //print(self.translatedText)
            print(deviseData.symbol[0])
            completionHandler(deviseData, nil)
        }
        task?.resume()
    }
    
}

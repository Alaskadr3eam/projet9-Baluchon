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

    private var arguments: [String: String] =
        [
         "access_key":Constant.apiKeyDevise
        ]
    
    
    private init () {}
 
    func getMoneyDevise(completionHandler: @escaping(DeviseData?,NetworkError?) -> Void) {
        var request = ServiceCreateRequest.createRequest(url: Constant.deviseUrl, arguments: arguments)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
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
            
            guard let deviseData = try? JSONDecoder().decode(DeviseData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                print("error responseJSON")
                
                return
            }
            print(deviseData.symbols.enumerated())
            completionHandler(deviseData, nil)
        }
        task?.resume()
    }
    
}

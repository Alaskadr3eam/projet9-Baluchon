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

    private var arguments: [String: String] =
        [
            "access_key":Constant.apiKeyMoney
    ]

    private var moneySession = URLSession(configuration: .default)
    
    init(moneySession: URLSession) {
        self.moneySession = moneySession
    }

    private init () {}

    func getMoneyCurrent(completionHandler: @escaping(MoneyData?,NetworkError?) -> Void) {
        guard var request = ServiceCreateRequest.createRequest(url: Constant.moneyUrl, arguments: arguments) else { return }
        request.httpMethod = "GET"
        task?.cancel()
        task = moneySession.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.emptyData)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                return
            }
            guard let moneyData = try? JSONDecoder().decode(MoneyData.self, from: data) else {
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                return
            }
            completionHandler(moneyData, nil)
        }
        task?.resume()
    }
    
}

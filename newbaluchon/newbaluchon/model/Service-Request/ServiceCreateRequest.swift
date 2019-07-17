//
//  ServiceCreateRequest.swift
//  newbaluchon
//
//  Created by Fiona on 11/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
struct ServiceCreateRequest {

    static func createRequest(url: URL, arguments: [String:String]) -> URLRequest {
        var request: URLRequest!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var items = [URLQueryItem]()
        let param = arguments
        for (key,value) in param {
            let queryItem = URLQueryItem(name: key, value: value)
            items.append(queryItem)
        }
        urlComponents?.queryItems = items
        let url = urlComponents?.url
        request = URLRequest(url: url!)
        return request
    }
}

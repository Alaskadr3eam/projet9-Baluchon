//
//  ServiceFakeData.swift
//  newbaluchonTests
//
//  Created by Clément Martin on 26/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static var moneyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "MoneyCurrent", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!

    static let translateIncorrectData = "erreur".data(using: .utf8)!

    static let moneyIncorrectData = "erreur".data(using: .utf8)!
    
    
}

class TestError: Error {
    static let error = TestError()
}



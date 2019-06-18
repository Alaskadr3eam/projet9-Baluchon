//
//  Money.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

struct MoneyData : Codable {
    var timestamp: Int
    var base: Int
    var rate: [Rates]
}

struct Rates: Codable {
    var rate: [String:Double]
}

struct DeviseData: Codable {
    var symbol: [Symbols]
}

struct Symbols: Codable {
    var symbol: [String: String]
}

//
//  Money.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import RealmSwift

struct MoneyData : Codable {
    var timestamp: Int
    var base: String
    var date: String
    let success: Bool
    var rate: [String:Double]
}
struct Rates: Codable {
    var AED: Double
    
}

struct DeviseData: Codable {
    var success: Bool
    let symbols: [String: String]
}
/*
struct Symbols: Codable {
    var symbol: [String: String]
}
*/
/*
class DeviseDataRealm: Object {
    var symbols = List<String>()
}
*/



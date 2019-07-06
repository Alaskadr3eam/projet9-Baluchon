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
    let rates: [String:Double]
}



class MoneyDataRealm: Object {
    @objc dynamic var timestamps = 0
    //@objc dynamic var date = String()
    var symbols = List<Rate>()
}

class Rate: Object {
    @objc dynamic var symbols = ""
    @objc dynamic var currencyValue = 0.0
}

struct DeviseData: Codable {
    let symbols: [String:String]
}

class SymbolsDataRealm: Object {
    @objc dynamic var code = ""
    @objc dynamic var name = ""
}

struct DeviseSource {
    var code = String()
    var name = String()
}



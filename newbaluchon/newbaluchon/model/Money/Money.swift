//
//  Money.swift
//  newbaluchon
//
//  Created by Clément Martin on 24/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import RealmSwift

class Money {

    var delegateAlerte: AlertMoneyDelegate?

    
    var arrayCurrencyEur = [String:Double]()
    var total = Double()

    //var deviseObject = DBManager.sharedInstance.getDataFromDBDeviseDataRealm()

    var delegateMoneyDelegate: UpdateMoneyDelegate?
/*
    func requestDevise() {
        DeviseService.shared.getMoneyDevise { (deviseData, error) in
            if let error = error {
                self.delegateAlerte?.alertError(error)
                return
            }
            guard let deviseData = deviseData else {
                return
            }
            self.delegateMoneyDelegate?.itIsResultRequestDevise(deviseData: deviseData)
        }
    }
*/
    func requestCurrency() {
        MoneyService.shared.getMoneyCurrent { (moneyData, error) in
            if let error = error {
                self.delegateAlerte?.alertError(error)
                return
            }
            guard let moneyData = moneyData else {
                print("errordata")
                return
            }
            self.delegateMoneyDelegate?.itIsResultRequestCurrency(moneyData: moneyData)
        }
    }

    func resultConversion(value: String, targetDevise: String) -> String {
        let valueDouble = value
        let currencyDevise = arrayCurrencyEur[targetDevise]?.formatToString()
        var result = "\(valueDouble)*\(currencyDevise)"
        return result
    }

    func calcul(value: String, targetDevise: String) {
        let mathExpression = NSExpression(format: resultConversion(value: value, targetDevise: targetDevise))
        guard let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double else { return }
        total = mathValue
    }
    

    
    
}

protocol UpdateMoneyDelegate {
    func itIsResultRequestDevise(deviseData: DeviseData)
    func itIsResultRequestCurrency(moneyData: MoneyData)
}
protocol AlertMoneyDelegate {
    func alertError(_ error: NetworkError)
}

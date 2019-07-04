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

    var date = String()
    var arrayCurrencyEur = [String:Double]()
    var total = Double()

    var objectsMoney = DBManager.sharedInstance.getDataFromDBMoneyDataRealm()
    var objectsDevise = DBManager.sharedInstance.getDataFromDBSymbolsDataRealm()
    var rate = Rate()

    //var deviseObject = DBManager.sharedInstance.getDataFromDBDeviseDataRealm()

    //var delegateMoneyDelegate: UpdateMoneyDelegate?
    var requestIsOk: Bool {
        return objectsMoney.count == 0
    }
    
    func allRequest() {
        if requestIsOk {
            requestCurrency()
            requestDevise()
            return
        } else /*if date == date*/{
            DBManager.sharedInstance.deleteFromDbSymbolsDataRealm(object: objectsDevise[0])
            requestDevise()
             DBManager.sharedInstance.deleteFromDbMoneyData(object: objectsMoney[0])
            requestCurrency()
        }
    }

    func requestDevise() {
       // DBManager.sharedInstance.deleteFromDbSymbolsDataRealm(object: objectsDevise[0])
        DeviseService.shared.getMoneyDevise { (deviseData, error) in
            if let error = error {
                self.delegateAlerte?.alertError(error)
                return
            }
            guard let deviseData = deviseData else {
                return
            }
            DispatchQueue.main.async {
                DBManager.sharedInstance.addDataSymbolsDataRealm(symbols: deviseData)
            }
            //self.delegateMoneyDelegate?.itIsResultRequestDevise(deviseData: deviseData)
        }
    }

    func requestCurrency() {
       // date = dateOfDay()
       // if date == objectsMoney[0]{
     //       return
       // } else {
        //    DBManager.sharedInstance.deleteFromDbMoneyData(object: objectsMoney[0])
        MoneyService.shared.getMoneyCurrent { (moneyData, error) in
            if let error = error {
                self.delegateAlerte?.alertError(error)
                return
            }
            guard let moneyData = moneyData else {
                print("errordata")
                return
            }
            DispatchQueue.main.async {
               DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
            }
            
         //   self.delegateMoneyDelegate?.itIsResultRequestCurrency(moneyData: moneyData)
        }
        //}
    }

    func dateOfDay() -> String {
        let aujourdHui = Date()
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd"
        formatDate.locale = Locale(identifier: "FR.fr")
        print ( "aujourd'hui : ",formatDate.string(from:aujourdHui))
        formatDate.locale = Locale.autoupdatingCurrent
        print ( "aujourd'hui : ",formatDate.string(from:aujourdHui))
        return formatDate.string(from:aujourdHui)
    }
/*
    func resultConversion(value: String, targetDevise: Double) -> String {
        let valueDouble = value
        let currentValeur = targetDevise
        let currencyString = currentValeur.formatToString()
        let result = "\(valueDouble)*\(currencyString)"
        return result
    }

    func calcul(value: String, targetDevise: Double) {
        let mathExpression = NSExpression(format: resultConversion(value: value, targetDevise: targetDevise))
        guard let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double else { return }
        total = mathValue
    }

    private func formatCurrencies(from currenciesList: DeviseData) -> [SymbolsDataRealm] {
        var primaryCurrencies = [SymbolsDataRealm]()
        var secondaryCurrencies = [SymbolsDataRealm]()
        
        for (currencyCode, currencyName) in currenciesList.symbols {
            let newCurrency = SymbolsDataRealm()
            newCurrency.code = currencyCode
            newCurrency.name = currencyName
            if self.mainCurrenciesCode.contains(currencyCode) {
                primaryCurrencies.append(newCurrency)
            } else {
                secondaryCurrencies.append(newCurrency)
            }
        }
        
        primaryCurrencies.sort(by: { (currencyA, currencyB) -> Bool in
            currencyA.name < currencyB.name
        })
        
        secondaryCurrencies.sort(by: { (currencyA, currencyB) -> Bool in
            currencyA.name < currencyB.name
        })
        
        return primaryCurrencies + secondaryCurrencies
    }
 */
/*
    func convert(value: String, targetDevise:String, sourceDevise: String) {
        let deviseSource = sourceDevise
        let targetCurrency = targetDevise
        /*
        guard let sourceValue = sourceValueTextField.text else {
            print("There is no value to convert")
            return
        }
 
        guard let sourceCurrencyRate = CurrencyService.shared.rates[sourceCurrency.code] else {
            print("Source currency rate not found")
            return
        }
        
        guard let targetCurrencyRate = CurrencyService.shared.rates[targetCurrency.code] else {
            print("Target currency rate not found")
            return
        }
        */
        let euroValue = (sourceValue as NSString).floatValue / sourceCurrencyRate
        
        let targetValue = euroValue * targetCurrencyRate
        if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
            targetValueTextField.text = String(Int(targetValue))
        } else {
            targetValueTextField.text = String(targetValue)
        }
    }
    
*/
    
    
}
/*
protocol UpdateMoneyDelegate {
    func itIsResultRequestDevise(deviseData: MoneyData)
    func itIsResultRequestCurrency(moneyData: MoneyData)
}
 */
protocol AlertMoneyDelegate {
    func alertError(_ error: NetworkError)
}

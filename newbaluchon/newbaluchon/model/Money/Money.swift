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
    var dataSource1 = [DeviseSource]()
    var dataSource2 = [DeviseSource]()
    var isSwitch = false
    
    var objectsMoney = DBManager.sharedInstance.getDataFromDBMoneyDataRealm()
    
    var requestIsOk: Bool {
        return objectsMoney.count == 0
    }
    
    var timestampIsOk: Bool {
        let timestampOfDay = timeStampOfDay()
        return objectsMoney[0].timestamps + 86400 < timestampOfDay
    }
    
    func allRequest() {
        if requestIsOk {
            requestCurrency()
            return
        } else if timestampIsOk {
            DBManager.sharedInstance.deleteFromDbMoneyData(object: objectsMoney[0])
            requestCurrency()
            return
        }
    }
    
    func prepareArrayRate() {
        for (key,value) in Constant.arrayDeviseSymbols {
            var deviseSource = DeviseSource()
            deviseSource.code = key
            deviseSource.name = value
            Constant.deviseSymbols.append(deviseSource)
        }
        
        for (key,value) in Constant.arrayDeviseSymbolEuro {
            var deviseSource = DeviseSource()
            deviseSource.code = key
            deviseSource.name = value
            Constant.deviseSymbolsEuro.append(deviseSource)
        }
        dataSource1 = Constant.deviseSymbolsEuro
        dataSource2 = Constant.deviseSymbols
    }
    
    private func searchDevise(deviseSearch: String) -> Double {
        var devise = Double()
        for i in objectsMoney[0].symbols {
            let range = i.symbols.lowercased().range(of: deviseSearch, options: .caseInsensitive, range: nil, locale: nil)
            if range != nil {
                devise = i.currencyValue
            }
        }
        return devise
    }
    
    func convert(view: MoneyView) {
        
        let sourceCurrency = view.pickerViewSource.selectedRow(inComponent: 0)
        let targetCurrency = view.pickerViewTarget.selectedRow(inComponent: 0)
        let deviseSource = dataSource1[sourceCurrency].code
        let deviseTarget = dataSource2[targetCurrency].code
        
        guard let sourceValue = view.sourceValueTextField.text else {
            return
        }
        
        let sourceCurrencyRate = searchDevise(deviseSearch: deviseSource)
        let targetCurrencyRate = searchDevise(deviseSearch: deviseTarget)
        if !isSwitch {
            let euroValue = (sourceValue as NSString).doubleValue// * targetCurrencyRate
            
            let targetValue = euroValue * targetCurrencyRate
            if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
                view.targetValueTextField.text = String(Int(targetValue))
            } else {
                view.targetValueTextField.text = String(targetValue)
            }
        } else {
            let deviseValue = (sourceValue as NSString).doubleValue
            let targetValue = deviseValue / sourceCurrencyRate
            if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
                view.targetValueTextField.text = String(Int(targetValue))
            } else {
                view.targetValueTextField.text = String(targetValue)
            }
        }
    }

    func exchangeDataSource(view: MoneyView) {
        exchange()
        view.pickerViewSource.reloadAllComponents()
        view.pickerViewTarget.reloadAllComponents()
        convert(view:view)
    }
    
    func exchange() {
        dataSource1 = isSwitch ? Constant.deviseSymbolsEuro : Constant.deviseSymbols
        dataSource2 = isSwitch ? Constant.deviseSymbols : Constant.deviseSymbolsEuro
        isSwitch = !isSwitch
    }

    func requestCurrency() {
        
        MoneyService.shared.getMoneyCurrent { (moneyData, error) in
            if let error = error {
                self.delegateAlerte?.alertError(error)
                return
            }
            guard let moneyData = moneyData else {
                self.delegateAlerte?.alertError(error!)
                return
            }
            DispatchQueue.main.async {
                DBManager.sharedInstance.addDataMoneyDataRealm(money: moneyData)
            }
        }
    }
    
    func timeStampOfDay() -> Int64 {
        let timestamp = Date().currentTime()
        return timestamp
    }
    
}

protocol AlertMoneyDelegate {
    func alertError(_ error: NetworkError)
}

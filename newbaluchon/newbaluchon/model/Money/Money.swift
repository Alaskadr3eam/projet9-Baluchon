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
    var errorMoney: NetworkError!
    var moneyCurrent: MoneyData!
    var objectsMoney = DBManager.sharedInstance.getDataFromDBMoneyDataRealm()
    
    var requestIsOk: Bool {
        return objectsMoney.count == 0
    }
    
    var timestampIsOk: Bool {
        let timestampOfDay = timeStampOfDay()
        return objectsMoney[0].timestamps + 86400 < timestampOfDay
    }

    private var moneyServiceSession = MoneyService(moneySession: URLSession(configuration: .default))
    init(moneyServiceSession: MoneyService) {
        self.moneyServiceSession = moneyServiceSession
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
    
    func searchDevise(deviseSearch: String) -> Double {
        var devise = Double()
        for i in objectsMoney[0].symbols {
            let range = i.symbols.lowercased().range(of: deviseSearch, options: .caseInsensitive, range: nil, locale: nil)
            if range != nil {
                devise = i.currencyValue
            }
        }
        return devise
    }
    
    func exchange() {
        dataSource1 = isSwitch ? Constant.deviseSymbolsEuro : Constant.deviseSymbols
        dataSource2 = isSwitch ? Constant.deviseSymbols : Constant.deviseSymbolsEuro
        isSwitch = !isSwitch
    }

    func requestCurrency() {
        moneyServiceSession.getMoneyCurrent { [weak self] (moneyData, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.errorMoney = error
                self.delegateAlerte?.alertError(self.errorMoney)
                return
            }
            guard let moneyData = moneyData else {
                self.delegateAlerte?.alertError(self.errorMoney)
                return
            }
            self.moneyCurrent = moneyData
            DispatchQueue.main.async {
                DBManager.sharedInstance.addDataMoneyDataRealm(money: self.moneyCurrent)
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

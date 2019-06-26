//
//  protocoleMoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 24/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import UIKit

extension MoneyViewController: UpdateMoneyDelegate {
    func itIsResultRequestCurrency(moneyData: MoneyData) {
        //DispatchQueue.main.async {
            //self.money.arrayCurrencyEur = moneyData.rate[0].rates
             // }
    }
    
    func itIsResultRequestDevise(deviseData: DeviseData) {
        /*
        for (key,value) in Constant.arrayDevise {
            Constant.arrayDeviseSymbols.append(key)
        }
        print(Constant.arrayDeviseSymbols.enumerated())
   /*     DispatchQueue.main.async {
            self.Constant.arrayDevise = deviseData.symbols
            for (key,value) in self.money.arrayDevise {
                self.money.arrayDeviseName.append(key)
            }
            print(Constant.arrayDeviseSymbols.enumerated())/*
            for i in 0...self.money.arrayDeviseName.count {
                var deviseDataRealm = DeviseDataRealm()
                deviseDataRealm.symbols[i] = self.money.arrayDeviseName[i]
                DBManager.sharedInstance.addDataDeviseData(object: deviseDataRealm)
            }
            print(self.money.deviseObject[0])
            print(self.money.arrayDeviseName[0])
     */   }
        moneyView.devisePickerViewTarget.reloadAllComponents()
    moneyView.devisePickerViewSource.reloadAllComponents()*/*/
    }
 
}

extension MoneyViewController: WhenButtonIsClickedDelegateInMoneyView {
    func buttonConvertIsClicked(value: String) {
        money.calcul(value: value, targetDevise: self.deviseTarget)
        moneyView.resultConvertLabel.text = money.total.formatToString()
        //moneyView.resultTauxConvertLabel.text = "\(money.arrayz
    }
}

extension MoneyViewController: AlertMoneyDelegate {
    func alertError(_ error: NetworkError) {
        DispatchQueue.main.async {
        self.alertVC(title: "error", message: error.rawValue)
        }
    }
}

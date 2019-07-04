//
//  protocoleMoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 24/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import UIKit
/*
extension MoneyViewController: UpdateMoneyDelegate {
    func itIsResultRequestDevise(deviseData: MoneyData) {
        
    }
    
    func itIsResultRequestCurrency(moneyData: MoneyData) {
       // DispatchQueue.main.async {
         //   self.money.arrayCurrencyEur = moneyData.rate[0].rates
           //   }
    }
    
    func itIsResultRequestDevise(deviseData: MoneyDataRealm) {
        
    /*    for (key,value) in Constant.arrayDevise {
            Constant.arrayDeviseSymbols.append(key)
        }
        print(Constant.arrayDeviseSymbols.enumerated())
      DispatchQueue.main.async {
            self.Constant.arrayDevise = deviseData.symbols
            for (key,value) in self.money.arrayDevise {
                self.money.arrayDeviseName.append(key)
            }
            print(Constant.arrayDeviseSymbols.enumerated())
            for i in 0...self.money.arrayDeviseName.count {
                var deviseDataRealm = DeviseDataRealm()
                deviseDataRealm.symbols[i] = self.money.arrayDeviseName[i]
                DBManager.sharedInstance.addDataDeviseData(object: deviseDataRealm)
            }
            print(self.money.deviseObject[0])
            print(self.money.arrayDeviseName[0])
       }
        moneyView.devisePickerViewTarget.reloadAllComponents()
    moneyView.devisePickerViewSource.reloadAllComponents()
 */
    }
 
}
*/
extension MoneyViewController: WhenButtonIsClickedDelegateInMoneyView {
    func textFieldSourceIsEdited(value: String) {
       convert()
       /* let index = moneyView.pickerViewTarget.selectedRow(inComponent: 0)
       money.calcul(value: moneyView.sourceValueTextField.text!, targetDevise: money.objectsMoney[0].symbols[index].currencyValue)
       moneyView.targetValueTextField.text = money.total.formatToString()
 */
    }
    
    func buttonConvertIsClicked() {
        interchangerButtonTaped()
        /*
        let currentSourceCurrency = moneyView.pickerViewSource.selectedRow(inComponent: 0)
        let currentTargetCurrency = moneyView.pickerViewTarget.selectedRow(inComponent: 0)
        
        moneyView.pickerViewSource.selectRow(currentTargetCurrency, inComponent: 0, animated: true)
        moneyView.pickerViewTarget.selectRow(currentSourceCurrency, inComponent: 0, animated: true)
        
        updateCurrencyLabel(pickerView: moneyView.pickerViewSource, row: currentTargetCurrency)
        updateCurrencyLabel(pickerView: moneyView.pickerViewTarget, row: currentSourceCurrency)
    
      //  money.calcul(value: moneyView.sourceValueTextField.text!, targetDevise: //money.objectsDevise[moneyView.pickerViewTarget.selectedRow(inComponent: 0)].code)
 */
     //   exchangeDataSource()
    }

}

extension MoneyViewController: AlertMoneyDelegate {
    func alertError(_ error: NetworkError) {
        DispatchQueue.main.async {
        self.alertVC(title: "error", message: error.rawValue)
        }
    }
}
/*
 print(money.objectsMoney.enumerated())
 //money.calcul(value: value, targetDevise: self.deviseTarget)
 //moneyView.resultConvertLabel.text = value + self.deviseSource + "=" + money.total.formatToString() + self.deviseTarget
 //moneyView.resultTauxConvertLabel.text = "\(money.arrayz
 */

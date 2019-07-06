//
//  ExtMoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 24/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import UIKit

extension MoneyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// Give the number of rows in the a pickerView's component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == moneyView.pickerViewSource ? dataSource1.count : dataSource2.count
    }
    
    /// Give the content of a row
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerView == moneyView.pickerViewSource ? dataSource1[row].name : dataSource2[row].name
    }
   
 
    /// Launch actions each time selected row changes
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateCurrencyLabel(pickerView: pickerView, row: row)
        convert()
    }
    
    func exchangeDataSource() {
        dataSource1 = isSwitch ? Constant.deviseSymbolsEuro : Constant.deviseSymbols
        dataSource2 = isSwitch ? Constant.deviseSymbols : Constant.deviseSymbolsEuro
        isSwitch = !isSwitch
        moneyView.pickerViewSource.reloadAllComponents()
        moneyView.pickerViewTarget.reloadAllComponents()
        updateCurrencyLabel(pickerView: moneyView.pickerViewSource, row: 0)
        updateCurrencyLabel(pickerView: moneyView.pickerViewTarget, row: 0)
        convert()
    }
    
    
   /* /// Reload data in the pickerviews
    fileprivate func reloadPickerViews() {
        moneyView.pickerViewSource.reloadComponent(0)
        moneyView.pickerViewTarget.reloadComponent(0)
        moneyView.pickerViewTarget.selectRow(1, inComponent: 0, animated: false)
    }*/
    
  
}


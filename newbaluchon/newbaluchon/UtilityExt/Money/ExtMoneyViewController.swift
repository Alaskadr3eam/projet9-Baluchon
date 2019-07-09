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
        return pickerView == moneyView.pickerViewSource ? money.dataSource1.count : money.dataSource2.count
    }
    
    /// Give the content of a row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == moneyView.pickerViewSource ? money.dataSource1[row].name : money.dataSource2[row].name
    }
    
    
    /// Launch actions each time selected row changes
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        moneyView.updateCurrencyLabel(pickerView: pickerView, row: row, money: money)
        money.convert(view: moneyView)
    }
    
    
}


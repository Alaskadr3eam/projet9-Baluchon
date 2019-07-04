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
       //if pickerView == moneyView.pickerViewSource {
        //    return Constant.arrayDeviseSymbolSource.count
      //  } else {
            return money.objectsDevise.count
      //  }
         //return money.objectsDevise.count
    }
    
    /// Give the content of a row
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      //  if pickerView == moneyView.pickerViewSource {
           
           // return "EUROPE"
      //  } else {
     
            return money.objectsDevise[row].name
    //    }
       // let currency = CurrencyService.shared.currencies[row]
      //  return currency.name
        //return money.objectsDevise[row].name
    }
   
 
    /// Launch actions each time selected row changes
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateCurrencyLabel(pickerView: pickerView, row: row)
        convert()
    }
    
    
    
    /// Reload data in the pickerviews
    fileprivate func reloadPickerViews() {
        moneyView.pickerViewSource.reloadComponent(0)
        moneyView.pickerViewTarget.reloadComponent(0)
        moneyView.pickerViewTarget.selectRow(1, inComponent: 0, animated: false)
    }
    
    /*///  Invert currencies
    @IBAction func interchangerButtonTaped(_ sender: Any) {
        let currentSourceCurrency = sourceCurrencyPickerView.selectedRow(inComponent: 0)
        let currentTargetCurrency = targetCurrencyPickerView.selectedRow(inComponent: 0)
        
        sourceCurrencyPickerView.selectRow(currentTargetCurrency, inComponent: 0, animated: true)
        targetCurrencyPickerView.selectRow(currentSourceCurrency, inComponent: 0, animated: true)
        
        updateCurrencyLabel(pickerView: sourceCurrencyPickerView, row: currentTargetCurrency)
        updateCurrencyLabel(pickerView: targetCurrencyPickerView, row: currentSourceCurrency)
        
        convert()
    }
*/
}


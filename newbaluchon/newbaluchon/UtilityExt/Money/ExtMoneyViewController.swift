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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constant.arrayDeviseSymbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case moneyView.devisePickerViewSource:
          self.deviseSource = Constant.arrayDeviseSymbols[row]
        case moneyView.devisePickerViewTarget:
           self.deviseTarget = Constant.arrayDeviseSymbols[row]
        default: return
        }
       // self.deviseSource = money.arrayDeviseName[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constant.arrayDeviseSymbols[row]
    }

}


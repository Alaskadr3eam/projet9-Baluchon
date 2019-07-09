//
//  MoneyView2.swift
//  newbaluchon
//
//  Created by Clément Martin on 27/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class MoneyView: UIView {
    
    var delegateConvert: WhenButtonIsClickedDelegateInMoneyView?
    
    @IBOutlet weak var sourceValueTextField: UITextField!
    @IBOutlet weak var sourceDeviseLabel: UILabel!
    @IBOutlet weak var pickerViewSource: UIPickerView!
    @IBOutlet weak var targetValueTextField: UITextField!
    @IBOutlet weak var targetDeviseLabel: UILabel!
    @IBOutlet weak var pickerViewTarget: UIPickerView!
    @IBOutlet weak var buttonXChange: UIButton!
    
    
    @IBAction func buttonIsClicked(_ Sender: UIButton) {
        delegateConvert?.buttonConvertIsClicked()
    }
    
    @IBAction func sourceValueTextFieldEdited(_ sender: UITextField) {
        if sourceValueTextField.text?.isEmpty == false{
            delegateConvert?.textFieldSourceIsEdited(value: sourceValueTextField.text!)
        } else {
            return
        }
    }
    
    func updateCurrencyLabel(pickerView: UIPickerView, row: Int, money: Money) {
        if pickerView == pickerViewSource {
            money.dataSource1 = money.isSwitch ? Constant.deviseSymbols : Constant.deviseSymbolsEuro
            sourceDeviseLabel.text = money.dataSource1[row].code
        } else {
            money.dataSource2 = money.isSwitch ? Constant.deviseSymbolsEuro : Constant.deviseSymbols
            targetDeviseLabel.text = money.dataSource2[row].code
        }
    }
    
}
protocol WhenButtonIsClickedDelegateInMoneyView {
    func buttonConvertIsClicked()
    func textFieldSourceIsEdited(value: String)
}

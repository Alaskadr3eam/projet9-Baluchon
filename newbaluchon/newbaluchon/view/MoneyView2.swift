//
//  MoneyView2.swift
//  newbaluchon
//
//  Created by Clément Martin on 27/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class MoneyView2: UIView {

    var delegateConvert: WhenButtonIsClickedDelegateInMoneyView?
    
    @IBOutlet weak var sourceValueTextField: UITextField!
    @IBOutlet weak var sourceDeviseLabel: UILabel!
    @IBOutlet weak var pickerViewSource: UIPickerView!
    @IBOutlet weak var targetValueTextField: UITextField!
    @IBOutlet weak var targetDeviseLabel: UILabel!
    @IBOutlet weak var pickerViewTarget: UIPickerView!
    @IBOutlet weak var buttonXChange: UIButton!


    @IBAction func buttonIsClicked(_ Sender: UIButton) {
       // let chosenCurrencySource = pickerViewSource.selectedRow(inComponent: 0)
        
       delegateConvert?.buttonConvertIsClicked()
    }
    
    @IBAction func sourceValueTextFieldEdited(_ sender: UITextField) {
        if sourceValueTextField.text?.isEmpty == false{
        delegateConvert?.textFieldSourceIsEdited(value: sourceValueTextField.text!)
        } else {
            return
        }
    }

    var point: Bool {
        let letters = CharacterSet.init(charactersIn: ".")
        let range = sourceValueTextField.text?.rangeOfCharacter(from: letters)
        if range != nil {
            return true
        }
        return false
    }

    

   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func exchangePickerView(pickerViewSource: UIPickerView, pickerViewTarget: UIPickerView){
        let componentSource = pickerViewSource.numberOfComponents
        let componentTarget = pickerViewTarget.numberOfComponents
       // pickerViewSource.
    }

}
protocol WhenButtonIsClickedDelegateInMoneyView {
    func buttonConvertIsClicked()
    func textFieldSourceIsEdited(value: String)
}

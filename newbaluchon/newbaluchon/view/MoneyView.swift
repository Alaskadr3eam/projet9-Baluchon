//
//  MoneyView.swift
//  newbaluchon
//
//  Created by Clément Martin on 24/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class MoneyView: UIView {

    var delegateConvert: WhenButtonIsClickedDelegateInMoneyView?
    
    @IBOutlet weak var moneyTextFieldSource: UITextField!
    @IBOutlet weak var devisePickerViewSource: UIPickerView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var devisePickerViewTarget: UIPickerView!
    @IBOutlet weak var resultConvertLabel: UILabel!
    @IBOutlet weak var resultTauxConvertLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func buttonIsClicked(_ Sender: UIButton) {
        
        delegateConvert?.buttonConvertIsClicked(value: moneyTextFieldSource.text!)
    }

}

protocol WhenButtonIsClickedDelegateInMoneyView {
    func buttonConvertIsClicked(value: String)
}

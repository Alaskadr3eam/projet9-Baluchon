//
//  protocoleMoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 24/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import UIKit

extension MoneyViewController: WhenButtonIsClickedDelegateInMoneyView {
    func textFieldSourceIsEdited(value: String) {
        money.convert(view: moneyView)
    }
    
    func buttonConvertIsClicked() {
        money.exchangeDataSource(view: moneyView)
        moneyView.updateCurrencyLabel(pickerView: moneyView.pickerViewSource, row: 0, money: money)
        moneyView.updateCurrencyLabel(pickerView: moneyView.pickerViewTarget, row: 0, money: money)
    }
    
}

extension MoneyViewController: AlertMoneyDelegate {
    func alertError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.alertVC(title: "error", message: error.rawValue)
        }
    }
}

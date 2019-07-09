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
        convert(view: moneyView)
    }

    private func reloadPickerView(view: MoneyView) {
        view.pickerViewSource.reloadAllComponents()
        view.pickerViewTarget.reloadAllComponents()
    }
    
    func buttonConvertIsClicked() {
        money.exchange()
        reloadPickerView(view: moneyView)
        convert(view: moneyView)
        moneyView.updateCurrencyLabel(pickerView: moneyView.pickerViewSource, row: 0, money: money)
        moneyView.updateCurrencyLabel(pickerView: moneyView.pickerViewTarget, row: 0, money: money)
    }
    
}

extension MoneyViewController: AlertMoneyDelegate {
    func alertError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.present(NetworkError.getAlert(error), animated: true)
        }
    }
}

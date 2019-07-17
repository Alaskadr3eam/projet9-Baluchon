//
//  MoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {
    
    let money = Money(moneyServiceSession: MoneyService.shared)
    
    
    @IBOutlet weak var moneyView: MoneyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        money.prepareArrayRate()
        money.allRequest()
        
        money.delegateAlerte = self
        moneyView.delegateConvert = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.initView(view: self.moneyView) }
    }

    func initPickerView() {
        moneyView.pickerViewSource.dataSource = self
        moneyView.pickerViewSource.delegate = self
        
        moneyView.pickerViewTarget.dataSource = self
        moneyView.pickerViewTarget.delegate = self
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        moneyView.sourceValueTextField.resignFirstResponder()
    }
    
    private func initView(view: MoneyView) {
        initPickerView()
        view.sourceValueTextField.text = "1"
        view.pickerViewSource.selectRow(0, inComponent: 0, animated: true)
        view.pickerViewTarget.selectRow(0, inComponent: 0, animated: true)
        view.sourceDeviseLabel.text = money.dataSource1[0].code
        view.targetDeviseLabel.text = money.dataSource2[0].code
        convert(view: view)
    }

    func convert(view: MoneyView) {
        
        let sourceCurrency = view.pickerViewSource.selectedRow(inComponent: 0)
        let targetCurrency = view.pickerViewTarget.selectedRow(inComponent: 0)
        let deviseSource = money.dataSource1[sourceCurrency].code
        let deviseTarget = money.dataSource2[targetCurrency].code
        
        guard let sourceValue = view.sourceValueTextField.text else {
            return
        }
        
        let sourceCurrencyRate = money.searchDevise(deviseSearch: deviseSource)
        let targetCurrencyRate = money.searchDevise(deviseSearch: deviseTarget)
        if !money.isSwitch {
            let euroValue = (sourceValue as NSString).doubleValue
            
            let targetValue = euroValue * targetCurrencyRate
            if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
                view.targetValueTextField.text = String(Int64(targetValue))
            } else {
                view.targetValueTextField.text = String(targetValue)
            }
        } else {
            let deviseValue = (sourceValue as NSString).doubleValue
            let targetValue = deviseValue / sourceCurrencyRate
            if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
                view.targetValueTextField.text = String(Int(targetValue))
            } else {
                view.targetValueTextField.text = String(targetValue)
            }
        }
    }
    
}

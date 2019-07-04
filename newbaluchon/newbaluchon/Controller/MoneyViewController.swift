//
//  MoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {

    let money = Money()
    //let deviseSource = DeviseSource()

    
/*
    let dataSourceAll = ["AED": "United Arab Emirates Dirham",
                          "AFN": "Afghan Afghani",
                          "ALL": "Albanian Lek",
                          "AMD": "Armenian Dram",
                          "ANG": "Netherlands Antillean Guilder",
                          "AOA": "Angolan Kwanza",
                          "ARS": "Argentine Peso",
                          "AUD": "Australian Dollar",
                          "AWG": "Aruban Florin",
                          "AZN": "Azerbaijani Manat"]
    let dataSourceEuro = ["EUR":"Europe"]
    */

    var deviseSource = String()
    var deviseTarget = String()
/*
    func exchangeDataSource() {
        moneyView.pickerViewSource.dataSource = dataSourceAll.count as? UIPickerViewDataSource
        moneyView.pickerViewTarget.dataSource = dataSourceEuro.count as? UIPickerViewDataSource
        
        moneyView.pickerViewTarget.reloadComponent(dataSourceEuro.count)
        moneyView.pickerViewSource.reloadComponent(dataSourceAll.count)
    }
*/
    @IBOutlet weak var moneyView: MoneyView2!

    override func viewDidLoad() {
        super.viewDidLoad()
        //money.allRequest()
        //money.delegateMoneyDelegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        money.delegateAlerte = self
        moneyView.delegateConvert = self
        initView(view: moneyView)
        moneyView.pickerViewSource.dataSource = self
        moneyView.pickerViewSource.delegate = self
        
        moneyView.pickerViewTarget.dataSource = self
        moneyView.pickerViewTarget.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        moneyView.sourceValueTextField.resignFirstResponder()
    }

    /// Update the short name of the currency near the value
     func updateCurrencyLabel(pickerView: UIPickerView, row: Int) {
        let currency = money.objectsDevise[row]
        if pickerView == moneyView.pickerViewSource {
            //let currency = money.objectsDevise[row]
            moneyView.sourceDeviseLabel.text = currency.code
        } else {
            
            moneyView.targetDeviseLabel.text = currency.code
        }
    }

 

    func initView(view: MoneyView2) {
        view.sourceValueTextField.text = "1"
        view.pickerViewSource.selectRow(130, inComponent: 0, animated: true)
        view.pickerViewTarget.selectRow(35, inComponent: 0, animated: true)
        view.sourceDeviseLabel.text = money.objectsDevise[130].code
        view.targetDeviseLabel.text = money.objectsDevise[35].code
    }

    fileprivate func reloadPickerViews() {
        moneyView.pickerViewSource.reloadComponent(0)
        moneyView.pickerViewTarget.reloadComponent(0)
        moneyView.pickerViewTarget.selectRow(1, inComponent: 0, animated: false)
    }

    func interchangerButtonTaped() {
        let currentSourceCurrency = moneyView.pickerViewSource.selectedRow(inComponent: 0)
        let currentTargetCurrency = moneyView.pickerViewTarget.selectedRow(inComponent: 0)
        
        moneyView.pickerViewSource.selectRow(currentTargetCurrency, inComponent: 0, animated: true)
        moneyView.pickerViewTarget.selectRow(currentSourceCurrency, inComponent: 0, animated: true)
        
        updateCurrencyLabel(pickerView: moneyView.pickerViewSource, row: currentTargetCurrency)
        updateCurrencyLabel(pickerView: moneyView.pickerViewTarget, row: currentSourceCurrency)
        
        convert()
    }

    func convert() {
        let sourceCurrency = moneyView.pickerViewSource.selectedRow(inComponent: 0)
        let targetCurrency = moneyView.pickerViewTarget.selectedRow(inComponent: 0)
     
        print(sourceCurrency)
        print(targetCurrency)
        guard let sourceValue = moneyView.sourceValueTextField.text else {
            return
        }
        
        let sourceCurrencyRate = money.objectsMoney[0].symbols[sourceCurrency].currencyValue
    
         let targetCurrencyRate = money.objectsMoney[0].symbols[targetCurrency].currencyValue
        
        let euroValue = (sourceValue as NSString).doubleValue / sourceCurrencyRate
        
        let targetValue = euroValue * targetCurrencyRate
        if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
            moneyView.targetValueTextField.text = String(Int(targetValue))
        } else {
            moneyView.targetValueTextField.text = String(targetValue)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

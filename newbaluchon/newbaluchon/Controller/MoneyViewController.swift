//
//  MoneyViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
class Devise {
    var name = String()
    var code = String()
}
class MoneyViewController: UIViewController {

    let money = Money()
    //let deviseSource = DeviseSource()

    
    var dataSource1 = [DeviseSource]()
    var dataSource2 = [DeviseSource]()
    var isSwitch = false
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
   
    

    var deviseSource = String()
    var deviseTarget = String()


    @IBOutlet weak var moneyView: MoneyView2!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableRate()
        money.allRequest()
        //money.delegateMoneyDelegate = self
        
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.initView(view: self.moneyView) }
    }

    override func viewWillAppear(_ animated: Bool) {
        money.delegateAlerte = self
        moneyView.delegateConvert = self
        //initView(view: moneyView)
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
    func tableRate() {
       
        for (key,value) in Constant.arrayDeviseSymbols {
            var deviseSource = DeviseSource()
            deviseSource.code = key
            deviseSource.name = value
            Constant.deviseSymbols.append(deviseSource)
        }
        print(Constant.deviseSymbols.enumerated())
 
        for (key,value) in Constant.arrayDeviseSymbolEuro {
            var deviseSource = DeviseSource()
            deviseSource.code = key
            deviseSource.name = value
            Constant.deviseSymbolsEuro.append(deviseSource)
          
        }
        dataSource1 = Constant.deviseSymbolsEuro
        dataSource2 = Constant.deviseSymbols
    }

    /// Update the short name of the currency near the value
     func updateCurrencyLabel(pickerView: UIPickerView, row: Int) {
        if pickerView == moneyView.pickerViewSource {
            dataSource1 = isSwitch ? Constant.deviseSymbols : Constant.deviseSymbolsEuro
            moneyView.sourceDeviseLabel.text = dataSource1[row].code
        } else {
            dataSource2 = isSwitch ? Constant.deviseSymbolsEuro : Constant.deviseSymbols
            moneyView.targetDeviseLabel.text = dataSource2[row].code
        }
    }

 

    func initView(view: MoneyView2) {
        view.sourceValueTextField.text = "1"
        view.pickerViewSource.selectRow(0, inComponent: 0, animated: true)
        view.pickerViewTarget.selectRow(0, inComponent: 0, animated: true)
        view.sourceDeviseLabel.text = dataSource1[0].code
        view.targetDeviseLabel.text = dataSource2[0].code
        convert()
    }

 /*   fileprivate func reloadPickerViews() {
        moneyView.pickerViewSource.reloadComponent(0)
        moneyView.pickerViewTarget.reloadComponent(0)
        moneyView.pickerViewTarget.selectRow(1, inComponent: 0, animated: false)
    }*/

  /*  func interchangerButtonTaped() {
        let currentSourceCurrency = moneyView.pickerViewSource.selectedRow(inComponent: 0)
        let currentTargetCurrency = moneyView.pickerViewTarget.selectedRow(inComponent: 0)
        
        moneyView.pickerViewSource.selectRow(currentTargetCurrency, inComponent: 0, animated: true)
        moneyView.pickerViewTarget.selectRow(currentSourceCurrency, inComponent: 0, animated: true)
        
        updateCurrencyLabel(pickerView: moneyView.pickerViewSource, row: currentTargetCurrency)
        updateCurrencyLabel(pickerView: moneyView.pickerViewTarget, row: currentSourceCurrency)
        
        convert()
    }*/

    func searchDevise(deviseSearch: String) -> Double {
        var devise = Double()// let letters = CharacterSet.init(charactersIn: deviseSearch)
        for i in money.objectsMoney[0].symbols {
            let range = i.symbols.lowercased().range(of: deviseSearch, options: .caseInsensitive, range: nil, locale: nil)
            if range != nil {
                devise = i.currencyValue
                print(devise)
            }
        }
        return devise
    }

    func convert() {
       
            let sourceCurrency = moneyView.pickerViewSource.selectedRow(inComponent: 0)
            let targetCurrency = moneyView.pickerViewTarget.selectedRow(inComponent: 0)
            let deviseSource = dataSource1[sourceCurrency].code
            let deviseTarget = dataSource2[targetCurrency].code
        
     
        print(sourceCurrency)
        print(targetCurrency)
        guard let sourceValue = moneyView.sourceValueTextField.text else {
            return
        }
        
        let sourceCurrencyRate = searchDevise(deviseSearch: deviseSource)
        let targetCurrencyRate = searchDevise(deviseSearch: deviseTarget)
        if !isSwitch {
        let euroValue = (sourceValue as NSString).doubleValue// * targetCurrencyRate
        
        let targetValue = euroValue * targetCurrencyRate
            if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
                moneyView.targetValueTextField.text = String(Int(targetValue))
            } else {
                moneyView.targetValueTextField.text = String(targetValue)
            }
        } else {
            let deviseValue = (sourceValue as NSString).doubleValue
            let targetValue = deviseValue / sourceCurrencyRate
            if targetValue.truncatingRemainder(dividingBy: 1) == 0 {
                moneyView.targetValueTextField.text = String(Int(targetValue))
            } else {
                moneyView.targetValueTextField.text = String(targetValue)
            }
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

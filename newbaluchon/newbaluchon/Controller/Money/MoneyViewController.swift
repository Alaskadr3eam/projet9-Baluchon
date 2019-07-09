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
    
    override func viewWillAppear(_ animated: Bool) {
      /* money.delegateAlerte = self
        moneyView.delegateConvert = self
        //initView(view: moneyView)
        moneyView.pickerViewSource.dataSource = self
        moneyView.pickerViewSource.delegate = self
        
        moneyView.pickerViewTarget.dataSource = self
        moneyView.pickerViewTarget.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)*/
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        moneyView.sourceValueTextField.resignFirstResponder()
    }
    
    func initView(view: MoneyView) {
        initPickerView()
        view.sourceValueTextField.text = "1"
        view.pickerViewSource.selectRow(0, inComponent: 0, animated: true)
        view.pickerViewTarget.selectRow(0, inComponent: 0, animated: true)
        view.sourceDeviseLabel.text = money.dataSource1[0].code
        view.targetDeviseLabel.text = money.dataSource2[0].code
        money.convert(view: view)
    }
    
}

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

    var deviseSource = String()
    var deviseTarget = String()

    @IBOutlet weak var moneyView: MoneyView!

    override func viewDidLoad() {
        super.viewDidLoad()
//money.requestDevise()
        money.requestCurrency()
        money.delegateMoneyDelegate = self
        money.delegateAlerte = self
        moneyView.delegateConvert = self
        
        moneyView.devisePickerViewSource.dataSource = self
        moneyView.devisePickerViewSource.delegate = self
        
        moneyView.devisePickerViewTarget.dataSource = self
        moneyView.devisePickerViewTarget.delegate = self
        

        // Do any additional setup after loading the view.
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

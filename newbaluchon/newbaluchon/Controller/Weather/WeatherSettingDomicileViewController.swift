//
//  WeatherSettingDomicileViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 14/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit


class WeatherSettingDomicileViewController: UIViewController {


    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet weak var cityTextField: UITextField!

    weak var delegateSaveCity: SaveCity?

    override func viewDidLoad() {
        super.viewDidLoad()
//initButtonSave()
        // Do any additional setup after loading the view.
    }

    func initButtonSave() {
        if cityTextField.text?.isEmpty == true {
            buttonSave.isHidden = true
        } else {
            buttonSave.isHidden = false
        }
    }

    @IBAction func saveCity() {
        delegateSaveCity?.saveCityInRealm(city: cityTextField.text!)
    }



}

protocol SaveCity: AnyObject {
    func saveCityInRealm(city: String)
}


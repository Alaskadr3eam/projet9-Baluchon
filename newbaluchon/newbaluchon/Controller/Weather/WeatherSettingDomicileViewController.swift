//
//  WeatherSettingDomicileViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 14/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import RealmSwift



class WeatherSettingDomicileViewController: UIViewController, UINavigationBarDelegate {

    let weather = Weather()

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    @IBOutlet weak var buttonAnnulate: UIBarButtonItem!
    
    @IBOutlet weak var cityTextField: UITextField!


    var cityTextIsEmpty: Bool {
        guard cityTextField.text?.isEmpty != true else {
            //alerte
            return false
        }
        return true
    }

    weak var delegateSaveCity: SaveCity?

    override func viewDidLoad() {
        super.viewDidLoad()
//initButtonSave()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveCity(view: WeatherView) {
        if !cityTextIsEmpty {
            return
        }
        delegateSaveCity?.saveCityInRealm(city: cityTextField.text!, view: view)
    }

    @IBAction func annulate() {
        dismiss(animated: true, completion: nil)
    }



}

protocol SaveCity: AnyObject {
    func saveCityInRealm(city: String, view: WeatherView)
}


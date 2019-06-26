//
//  AddCityWeatherUIViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 15/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class AddCityWeatherUIViewController: UIViewController {

    var delegateSaveCityHoliday: SaveCityHolidayDelegate?
    
    
    @IBOutlet weak var cityNameTextField: UITextField!

    var cityTextIsEmpty: Bool {
        guard cityNameTextField.text?.isEmpty != true else {
            //alerte
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveCity(view: WeatherView) {
        if !cityTextIsEmpty {
            return
        }
        delegateSaveCityHoliday?.saveCityHolidayRealm(city: cityNameTextField.text!)
    }
    
    @IBAction func annulate() {
        dismiss(animated: true, completion: nil)
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

protocol SaveCityHolidayDelegate {
    func saveCityHolidayRealm(city: String)
}


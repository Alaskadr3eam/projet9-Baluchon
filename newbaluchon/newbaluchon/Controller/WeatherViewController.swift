//
//  WeatherViewController.swift
//  newbaluchon
//
//  Created by Fiona on 30/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //code
    }
    
    @IBAction func tappedButtonWeather() {
        WeatherService.shared.createTranslateRequest(city: "paris")
        WeatherService.shared.getWeather { (weatherData, error) in
            if error == nil, let weatherData = weatherData {
                print(weatherData.name)
            } else {
                //
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

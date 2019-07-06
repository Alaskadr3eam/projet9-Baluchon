//
//  WeatherCollectionViewCell.swift
//  newbaluchon
//
//  Created by Clément Martin on 14/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var imageBackgound: UIImageView!
    @IBOutlet weak var stackViewHoliday: UIStackView!


    func toggleActivityIndicator(shown: Bool) {

        labelTemp.isHidden = shown
        labelCityName.isHidden = shown
        labelDescription.isHidden = shown
        imageWeather.isHidden = shown
    }

    func initImage() {
        imageWeather.contentMode = .scaleAspectFit
    }
    
}

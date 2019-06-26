//
//  WeatherView.swift
//  newbaluchon
//
//  Created by Clément Martin on 20/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    var delegateWeahter: WeatherViewDelegate?

    @IBOutlet weak var labelDomicileCity: UILabel!
    @IBOutlet weak var labelDomicileTemp: UILabel!
    @IBOutlet weak var labelDomicileDescription: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var buttonList: UIButton!
    @IBOutlet weak var buttonSetting: UIBarButtonItem!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func buttonClicked(sender: UIButton) {
        switch sender {
        case buttonList:
             delegateWeahter?.whenButtonListIsClicked()
        case buttonSetting:
            delegateWeahter?.whenButtonSettingIsClicked()
        default:
            return
        }
    }

}

protocol WeatherViewDelegate {
    func whenButtonListIsClicked()
    func whenButtonSettingIsClicked()
}

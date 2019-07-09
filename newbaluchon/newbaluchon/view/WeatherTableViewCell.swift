//
//  WeatherTableViewCell.swift
//  newbaluchon
//
//  Created by Clément Martin on 08/07/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var imageCell: UIImageView!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet weak var newLabelTitle: UILabel!
    @IBOutlet weak var newLabelDetail: UILabel!
    @IBOutlet weak var swipeDelete: UISwipeGestureRecognizer!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
}

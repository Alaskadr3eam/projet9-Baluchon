//
//  CustomPageControl.swift
//  newbaluchon
//
//  Created by Clément Martin on 18/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class LocationPageControl: UIPageControl {
    
    let locationArrow: UIImage = UIImage(named: "locationArrow")!
    let pageCircle: UIImage = UIImage(named: "pageCircle")!
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
    }
    
    func updateDots() {
        var i = 0
        for view in self.subviews {
            var imageView = self.imageView(forSubview: view)
            if imageView == nil {
                if i == 0 {
                    imageView = UIImageView(image: locationArrow)
                } else {
                    imageView = UIImageView(image: pageCircle)
                }
                imageView!.center = view.center
                view.addSubview(imageView!)
                view.clipsToBounds = false
            }
            if i == self.currentPage {
                imageView!.alpha = 1.0
            } else {
                imageView!.alpha = 0.5
            }
            i += 1
        }
    }
    
    fileprivate func imageView(forSubview view: UIView) -> UIImageView? {
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }
}

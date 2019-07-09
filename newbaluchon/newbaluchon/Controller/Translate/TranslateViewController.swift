//
//  ViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 20/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import CoreLocation


class TranslateViewController: UIViewController {
    
    var translate = Translate()
    @IBOutlet weak var translateView: TranslateView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        initLocationManager()
        translateView.delegateTranslateView = self
        translate.delegateScreen = self
        translate.delegateAlert = self
        
        translateView.initButtonLanguage(titleS: Language.list[0].name, codeS: Language.list[0].code, titleT: Language.list[1].name, codeT: Language.list[1].code)
        
        translateView.textSource.delegate = self
        
        initGeneral()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initGeneral()
    }

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func initGeneral() {
        translateView.toggleActivityIndicator(shown: false)
        customTextViewPlaceholder(textView: translateView.textSource)
        customTextView(textView: translateView.textTranslated)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueLanguageTableView {
            if let languageVC = segue.destination as? LanguageTableViewController {
                if let sender = sender as? UIButton {
                    switch sender.tag {
                    case 1:
                        languageVC.delegate = self
                        languageVC.sender = sender
                    case 2:
                        languageVC.delegate = self
                        languageVC.sender = sender
                    default: return
                    }
                }
            }
        }
    }
}


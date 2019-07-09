//
//  Translate.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class TranslateView: UIView {
    
    var delegateTranslateView: CommunicationTranslateView?
    
    @IBOutlet weak var languageSource: UIButton!
    @IBOutlet weak var languageTarget: UIButton!
    @IBOutlet weak var textSource: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var textTranslated: UITextView!
    @IBOutlet weak var deleteText: UIButton!
    @IBOutlet weak var switchLanguage: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    var textSourceIsNotEmpty: Bool {
        if textSource.text.isEmpty == true || textSource.text == "Placeholder" {
            return false
        }
        return true
    }
    
    @IBAction func buttonIsClicked(sender: UIButton) {
        switch sender.tag {
        case 1:
            delegateTranslateView?.WhenButtonLanguageIsClicked(sender: sender)
        case 2:
            delegateTranslateView?.WhenButtonLanguageIsClicked(sender: sender)
        case 3:
            if !textSourceIsNotEmpty {
                //alerte
                return
            }
            toggleActivityIndicator(shown: true)
            delegateTranslateView?.whenButtonTranslateIsClicked(textSource: textSource.text, sourceLangueCode: languageSource.accessibilityIdentifier!, targetLangueCode: languageTarget.accessibilityIdentifier!)
        case 4:
            delegateTranslateView?.WhenButtonDeleteIsClicked(view: self)
        case 5:
            exchangeLanguage(senderTarget: languageTarget, senderSource: languageSource)
        default:return
        }
    }
    
    func initButtonLanguage(titleS: String, codeS: String, titleT: String, codeT: String) {
        languageSource.setTitle(titleS, for: .normal)
        languageSource.accessibilityIdentifier = codeS
        
        languageTarget.setTitle(titleT, for: .normal)
        languageTarget.accessibilityIdentifier = codeT
    }
    
    func exchangeLanguage(senderTarget: UIButton, senderSource: UIButton) {
        let code = senderSource.accessibilityIdentifier
        let name = senderSource.title(for: .normal)
        let code1 = senderTarget.accessibilityIdentifier
        let name1 = senderTarget.title(for: .normal)
        senderSource.setTitle(name1, for: .normal)
        senderSource.accessibilityIdentifier = code1
        senderTarget.setTitle(name, for: .normal)
        senderTarget.accessibilityIdentifier = code
    }
    
    func toggleActivityIndicator(shown: Bool) {
        indicatorActivity.isHidden = !shown
        translateButton.isHidden = shown
    }
    
    func printResultTranslate(translation: String) {
        textTranslated.text = translation
    }
    
    
}
protocol CommunicationTranslateView {
    func whenButtonTranslateIsClicked(textSource: String, sourceLangueCode: String, targetLangueCode: String)
    func WhenButtonLanguageIsClicked(sender: UIButton)
    func WhenButtonDeleteIsClicked(view: TranslateView)
    func WhenButtonSwitchLanguageIsClicked(senderS: UIButton, senderT: UIButton)
}


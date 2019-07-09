//
//  protocole.swift
//  newbaluchon
//
//  Created by Clément Martin on 21/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation
import UIKit

extension TranslateViewController: LanguageTableViewControllerDelegate {
    func changeLanguage(language: Language, sender: UIButton) {
        switch sender.tag {
        case 1:
            sender.setTitle(language.name, for: .normal)
            sender.accessibilityIdentifier = language.code
            
        case 2:
            sender.setTitle(language.name, for: .normal)
            sender.accessibilityIdentifier = language.code
        default: return
        }
    }
}
extension TranslateViewController: CommunicationTranslateView {
    func whenButtonTranslateIsClicked(textSource: String, sourceLangueCode: String, targetLangueCode: String) {
        translate.submitTranslate(textSource: textSource, source: sourceLangueCode, target: targetLangueCode)
    }
    
    func WhenButtonSwitchLanguageIsClicked(senderS: UIButton, senderT: UIButton) {
    }
    
    
    func WhenButtonLanguageIsClicked(sender: UIButton) {
        performSegue(withIdentifier: Constant.segueLanguageTableView, sender: sender)
    }
    
    func WhenButtonDeleteIsClicked(view: TranslateView) {
        view.textSource.text = ""
        view.toggleActivityIndicator(shown: false)
    }
}

extension TranslateViewController: UpdateTranslate {
    func itIsResultTranslation(text: String) {
        DispatchQueue.main.async {
            self.translateView.textTranslated.text = text
            self.translateView.indicatorActivity.isHidden = true
        }
    }
}

extension TranslateViewController: AlertTranslateDelegate {
    func alertError(_ error: NetworkError) {
        self.present(NetworkError.getAlert(error), animated: true)
    }
}

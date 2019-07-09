//
//  Translate.swift
//  newbaluchon
//
//  Created by Clément Martin on 20/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import Foundation

class Translate {

    var delegateScreen: UpdateTranslate?
    var delegateAlert: AlertTranslateDelegate?

    var translatedText: String?
    

    func textSourceNotEmpty(textSource: String) -> Bool {
        if textSource.isEmpty == true || textSource == "Placeholder" {
            //alert
            return false
        } else {
            return true
        }
    }

    func submitTranslate(textSource: String, source: String, target: String) {
        if !textSourceNotEmpty(textSource: textSource) {
            return
        }
        TranslateService.shared.getTranslate(text: textSource, source: source, target: target) { (translationData, error) in
            if let error = error {
                self.delegateAlert?.alertError(error)
                return
            }
            guard let translationData = translationData else {
                return
            }
            self.delegateScreen?.itIsResultTranslation(text: translationData.data.translations[0].translatedText)
        }
        
    }
 
}
protocol UpdateTranslate {
    func itIsResultTranslation(text: String)
}
protocol AlertTranslateDelegate {
    func alertError(_ error: NetworkError)
}

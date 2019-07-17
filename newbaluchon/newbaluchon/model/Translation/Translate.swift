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

    var translatedText: String!
    
    var errorTranslate: String?

    private var translateServiceSession = TranslateService(translateSession: URLSession(configuration: .default))
    init(translateServiceSession: TranslateService) {
        self.translateServiceSession = translateServiceSession
    }

    func textSourceNotEmpty1(textSource: String) -> Bool {
        
            return textSource.isEmpty == false || textSource == "Placeholder"
        }
    
    

    func submitTranslate(textSource: String, source: String, target: String) {
        if !textSourceNotEmpty1(textSource: textSource) {
            return
        }
        translateServiceSession.getTranslate(text: textSource, source: source, target: target) { [weak self] (translationData, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.errorTranslate = error.rawValue
                self.delegateAlert?.alertError(error)
                return
            }
            guard let translationData = translationData else {
                return
            }
            self.translatedText = translationData.data.translations[0].translatedText
            self.delegateScreen?.itIsResultTranslation(text: self.translatedText)
        }
    }
}

protocol UpdateTranslate {
    func itIsResultTranslation(text: String)
}
protocol AlertTranslateDelegate {
    func alertError(_ error: NetworkError)
}

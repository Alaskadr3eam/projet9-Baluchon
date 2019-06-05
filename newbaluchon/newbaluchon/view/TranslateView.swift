//
//  Translate.swift
//  newbaluchon
//
//  Created by Clément Martin on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class TranslateView: UIView {

    var delegateTranslateView: communicationTranslateView?

    @IBOutlet weak var languageSource: UIButton!
    @IBOutlet weak var languageTarget: UIButton!
    @IBOutlet weak var textSource: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var textTranslated: UITextView!
    @IBOutlet weak var deleteText: UIButton!
    @IBOutlet weak var switchLanguage: UIButton!

    @IBAction func buttonIsClicked() {
        delegateTranslateView?.whenButtonIsClicked(q: textSource.text, source: (languageSource.titleLabel?.text)!, target: (languageTarget.titleLabel?.text)!)
    }

    func printResultTranslate(translation: String) {
        textTranslated.text = translation
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
protocol communicationTranslateView {
    func whenButtonIsClicked(q: String, source: String, target: String)
}


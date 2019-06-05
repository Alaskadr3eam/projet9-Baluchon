//
//  ViewController.swift
//  newbaluchon
//
//  Created by Fiona on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, LanguageTableViewControllerDelegate {
    func changeLanguage(language: Language, sender: UIButton) {
        sender.setTitle(language.name, for: .normal)
        sender.accessibilityIdentifier = language.code
    }
    


    
    
    @IBOutlet weak var languageSource: UIButton!
    @IBOutlet weak var languageTarget: UIButton!
    @IBOutlet weak var textSource: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var textTranslated: UITextView!
    @IBOutlet weak var deleteText: UIButton!
    @IBOutlet weak var switchLanguage: UIButton!
    
    //let translate = Translate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTextViewPlaceholder(textView: textSource)
        customTextView(textView: textTranslated)
        toggleActivityIndicator(shown: false)
        setButton()

        textSource.delegate = self
 
    }
    
    @IBAction func submitTranslate() {
        self.toggleActivityIndicator(shown: true)
        TranslateService.shared.createTranslateRequest(text: textSource.text, source: languageSource.accessibilityIdentifier!, target: languageTarget.accessibilityIdentifier!)
        TranslateService.shared.getTranslate { (translationData, error) in
            if error == nil && translationData == nil {
                self.textTranslated.text = TranslateService.shared.translatedText
                self.indicatorActivity.isHidden = true
            } else {
            //
            }
        }
    }

    @IBAction func deletedText() {
        customTextViewPlaceholder(textView: textSource)
        textTranslated.text = ""
        self.toggleActivityIndicator(shown: false)
    }

    @IBAction func reverseLanguage(sender: UIButton) {
        let code = languageSource.accessibilityIdentifier
        let name = languageSource.title(for: .normal)
            let code1 = languageTarget.accessibilityIdentifier
            let name1 = languageTarget.title(for: .normal)
            languageSource.setTitle(name1, for: .normal)
            languageSource.accessibilityIdentifier = code1
        languageTarget.setTitle(name, for: .normal)
        languageTarget.accessibilityIdentifier = code
    }

    private func exchangeLanguage() {
        
    }

    private func toggleActivityIndicator(shown: Bool) {
        indicatorActivity.isHidden = !shown
        translateButton.isHidden = shown
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choiceLanguage", let languageVC = segue.destination as? LanguageTableViewController, let sender = sender as? UIButton {
            languageVC.delegate = self
            languageVC.sender = sender
            if sender == languageSource {
                
                //languageVC.language = languageSource
            }
            else {
                //languageVC.language = Settings.Translation.targetLanguage
            }
        }
    }

    /// Go to Language scene when language button is tapped
    @IBAction func languageButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "choiceLanguage", sender: sender)
    }
}

extension TranslateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Placeholder" {
            customTextView(textView: textView)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            customTextViewPlaceholder(textView: textView)
        }
    }
    
    func customTextViewPlaceholder(textView: UITextView) {
        textView.text = "Placeholder"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "verdana", size: 13.0)
        textView.returnKeyType = .done
    }
    
    func customTextView(textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
        textView.font = UIFont(name: "verdana", size: 18.0)
    }
}

extension TranslateViewController {
    func setButton () {
        
    /* languageSource.setTitle(Setting.shared.languageSource.name, for: .normal)
        languageSource.value(forKeyPath: Setting.shared.languageSource.code)
        languageSource.currentAttributedTitle = Setting.shared.languageSource.code
        
        languageTarget.setTitle(Setting.shared.languageTarget.name, for: .normal)
        languageTarget.value(forKeyPath: Setting.shared.languageTarget.code)
   */ }
}
 
    /*
     private func translation(_ sender: UIButton) {
        TranslateService.shared.getTranslate(q: textSource.text, source: (languageSource.titleLabel?.text)!, target: (languageTarget.titleLabel?.text)!)
        self.updateTextFieldTranslated()
    }
*/
    




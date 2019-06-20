//
//  ViewController.swift
//  newbaluchon
//
//  Created by Fiona on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import RealmSwift

class TranslateViewController: UIViewController {

    @IBOutlet weak var languageSource: UIButton!
    @IBOutlet weak var languageTarget: UIButton!
    @IBOutlet weak var textSource: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var textTranslated: UITextView!
    @IBOutlet weak var deleteText: UIButton!
    @IBOutlet weak var switchLanguage: UIButton!

    var textSourceIsNotEmpty: Bool {
        if textSource.text.isEmpty == true || textSource.text == "Placeholder" {
            //Alerte
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initButton(source: languageSource, target: languageTarget)
        customTextViewPlaceholder(textView: textSource)
        customTextView(textView: textTranslated)
        toggleActivityIndicator(shown: false)
     // DBManager.sharedInstance.deleteAllFromDatabase()
        textSource.delegate = self
 
    }

    func initButton(source: UIButton, target: UIButton) {
        source.setTitle(Language.list[0].name, for: .normal)
        source.accessibilityIdentifier = Language.list[0].code
        
        target.setTitle(Language.list[1].name, for: .normal)
        target.accessibilityIdentifier = Language.list[1].code
    }
    
    @IBAction func submitTranslate() {
        if !textSourceIsNotEmpty {
            return
        }
        self.toggleActivityIndicator(shown: true)
        TranslateService.shared.getTranslate(text: textSource.text, source: languageSource.accessibilityIdentifier!, target: languageTarget.accessibilityIdentifier!) { (translationData, error) in
            if let error = error {
                //alert
                return
            }
            guard let translationData = translationData else {
                return
            }
                DispatchQueue.main.async {
                    self.textTranslated.text = translationData.data.translations[0].translatedText
                    self.indicatorActivity.isHidden = true
            }
            }
        
    }

    @IBAction func deletedText() {
        customTextViewPlaceholder(textView: textSource)
        textTranslated.text = ""
        self.toggleActivityIndicator(shown: false)
    }

    @IBAction func reverseLanguage(sender: UIButton) {
        exchangeLanguage()
    }

    private func exchangeLanguage() {
        let code = languageSource.accessibilityIdentifier
        let name = languageSource.title(for: .normal)
        let code1 = languageTarget.accessibilityIdentifier
        let name1 = languageTarget.title(for: .normal)
        languageSource.setTitle(name1, for: .normal)
        languageSource.accessibilityIdentifier = code1
        languageTarget.setTitle(name, for: .normal)
        languageTarget.accessibilityIdentifier = code
    }

    private func toggleActivityIndicator(shown: Bool) {
        indicatorActivity.isHidden = !shown
        translateButton.isHidden = shown
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueLanguageTableView {
            if let languageVC = segue.destination as? LanguageTableViewController {
                if let sender = sender as? UIButton {
            languageVC.delegate = self
            languageVC.sender = sender
                }
            }
        }
    }

    /// Go to Language scene when language button is tapped
    @IBAction func languageButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Constant.segueLanguageTableView, sender: sender)
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

extension TranslateViewController: LanguageTableViewControllerDelegate  {

    func changeLanguage(language: Language, sender: UIButton) {
        sender.setTitle(language.name, for: .normal)
        sender.accessibilityIdentifier = language.code
    }

}
 

    




//
//  LanguageTableViewController.swift
//  newbaluchon
//
//  Created by Fiona on 29/05/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {
    
    var language: Language?
    
    var sender: UIButton?
    
    var delegate: LanguageTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.list.count
    }    
    /// Validates the selection of a language
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        language = Language.list[indexPath.row]
        if let language = language, let sender = sender {
            delegate?.changeLanguage(language: language, sender: sender)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        
        let language = Language.list[indexPath.row]
        cell.textLabel?.text = language.name
        
        if let currentLanguage = self.language, currentLanguage.code == language.code {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

protocol LanguageTableViewControllerDelegate {
    /// Change the source or target language
    func changeLanguage(language: Language, sender: UIButton)
}

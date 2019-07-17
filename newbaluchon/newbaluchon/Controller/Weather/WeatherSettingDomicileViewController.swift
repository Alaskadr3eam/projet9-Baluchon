//
//  WeatherSettingDomicileViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 14/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherSettingDomicileViewController: UIViewController {
    
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var tblCountryList: UITableView!

    let weather = Weather(weatherServiceSession: WeatherService.shared)
    
    var city = Cities()
    
    var cityName:[String] = Array()
    var cityNameSearch:[String] = Array()
    var countryName:[String] = Array()
    
    var cityTextIsEmpty: Bool {
        guard txtSearchBar.text?.isEmpty != true else {
            return false
        }
        return true
    }
    
    weak var delegateSaveCity: SaveCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCountryList.isHidden = true
        tblCountryList.delegate = self
        tblCountryList.dataSource = self
        tblCountryList.layer.masksToBounds = true
        tblCountryList.separatorInset = UIEdgeInsets.zero
        tblCountryList.layer.cornerRadius = 5.0
        tblCountryList.separatorColor = UIColor.lightGray
        tblCountryList.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        txtSearchBar.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search")
        imageView.image = image
        txtSearchBar.leftView = imageView
        
        city = loadJson(fileName: "countries")!

    }
    
    @objc func searchRecords(_ textField: UITextField) {
        searchCountrie(textField)
        tblCountryList.reloadData()
    }
    
    func loadJson(fileName: String) -> Cities? {
        if let url = Bundle.main.url(forResource: fileName, withExtension:"json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Cities.self, from: data)
                return jsonData
            } catch {
                alertVC(title: "Erreur", message: "Le document des villes n'a pas été traduit ! Contactez le développeur")
            }
        }
        return nil
    }
    
    private func searchCountrie(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        self.cityName.removeAll()
        self.countryName.removeAll()
    
        tblCountryList.isHidden = text.isEmpty
        
        if textField.text?.count != 0 {
            tblCountryList.isHidden = false
            for (key,_) in city {
                guard let keySecure = city[key] else {
                    break
                }
                for i in 0...keySecure.count - 1 {
                    if let countrySearch = textField.text {
                        let range = keySecure[i].lowercased().range(of: countrySearch, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.countryName.append(keySecure[i])
                            self.cityName.append(key)
                        }
                    }
                }
            }                }
        for (key,value) in city {
            if textField.text == key {
                cityName = value
            }
        }
        tblCountryList.reloadData()
    }

}

extension WeatherSettingDomicileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        cell.textLabel?.text = "\(countryName[indexPath.row]), \(cityName[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        txtSearchBar.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        if let text = txtSearchBar.text {
            delegateSaveCity?.saveCityInRealm(city: text)
        }
    }
    
    
}

extension WeatherSettingDomicileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }
}

protocol SaveCity: AnyObject {
    func saveCityInRealm(city: String)
}

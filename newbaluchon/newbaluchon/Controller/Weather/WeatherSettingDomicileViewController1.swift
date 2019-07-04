//
//  WeatherSettingDomicileViewController1.swift
//  newbaluchon
//
//  Created by Clément Martin on 03/07/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class WeatherSettingDomicileViewController1: UIViewController {

    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var tblCountryList: UITableView!
    @IBOutlet weak var buttonAnulate: UIBarButtonItem!

    let weather = Weather()

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
        // searchBar2.addTarget(self, action: #selector(searchCityRecord(_ :)), for: .editingChanged)
        txtSearchBar.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search")
        imageView.image = image
        txtSearchBar.leftView = imageView

        city = loadJson(fileName: "countries")!
        // Do any additional setup after loading the view.
    }

    @objc func searchRecords(_ textField: UITextField) {
        searchCountrie(textField)
        tblCountryList.reloadData()
    }
/*
    @IBAction func annulate() {
        if !cityTextIsEmpty {
            alertVC(title: "Attention", message: "Il faut absolument entrer une ville d'origine")
            return
        }
        dismiss(animated: true, completion: nil)
    }
*/
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

    func searchCountrie(_ textField: UITextField) {
        self.cityName.removeAll()
        self.countryName.removeAll()
        
        if textField.text?.isEmpty == true {
            tblCountryList.isHidden = true
        }
        if textField.text?.count != 0 {
            tblCountryList.isHidden = false
            for (key,_) in city {
                for i in 0...city[key]!.count - 1 {
                    if let countrySearch = textField.text {
                        
                        let range = city[key]![i].lowercased().range(of: countrySearch, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.countryName.append(city[key]![i])
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

    func searchCity(_ textField: UITextField) {
        self.cityNameSearch.removeAll()
        if textField.text?.isEmpty == true {
            tblCountryList.isHidden = true
        }
        if textField.text?.count != 0 {
            tblCountryList.isHidden = false
            for name in cityName {
                if let countrySearch = textField.text {
                    var countrySearchMutable = countrySearch
                    let range = name.lowercased().range(of: countrySearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.cityNameSearch.append(name)
                    }
                }
            }
            
        }
        tblCountryList.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherSettingDomicileViewController1: UITableViewDelegate, UITableViewDataSource {
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
        //  let vcDestination = UIStoryboard.instantiateViewController(withIdentifier: "WeatherTableViewController")
        //  let detVC = self.storyboard?.instantiateViewController(withIdentifier: "WeatherTableViewController") as! WeatherTableViewController
        txtSearchBar.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        delegateSaveCity?.saveCityInRealm(city: txtSearchBar.text!)
        //self.navigationController?.pushViewController(detVC, animated: true)
    }
    
    
}

extension WeatherSettingDomicileViewController1: UITextFieldDelegate {
    
}

protocol SaveCity: AnyObject {
    func saveCityInRealm(city: String)
}

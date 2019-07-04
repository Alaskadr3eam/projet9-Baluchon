//
//  SettingTableViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 01/07/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit


class SettingTableViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var tblCountryList: UITableView!
    @IBOutlet weak var buttonAnulate: UIBarButtonItem!
   // @IBOutlet weak var searchBar2: UITextField!

    let weather = Weather()

    var delegateSaveCityHoliday: SaveCityHolidayDelegate?
    
    
    
    var cityName:[String] = Array()
    var cityNameSearch:[String] = Array()
    var countryName:[String] = Array()
    var city = Cities()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        city = loadJson(fileName: "countries")!
        // Do any additional setup after loading the view.
       // searchBar2.isHidden = true
        tblCountryList.isHidden = true
        tblCountryList.delegate = self
        tblCountryList.dataSource = self
        tblCountryList.layer.masksToBounds = true
        tblCountryList.separatorInset = UIEdgeInsets.zero
        tblCountryList.layer.cornerRadius = 5.0
        tblCountryList.separatorColor = UIColor.lightGray
        tblCountryList.backgroundColor = UIColor.white.withAlphaComponent(0.4)
       // searchBar2.delegate = self
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
       // searchBar2.addTarget(self, action: #selector(searchCityRecord(_ :)), for: .editingChanged)
        txtSearchBar.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search")
        imageView.image = image
        txtSearchBar.leftView = imageView
    }

    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }

    
    @IBAction func annulate() {
        dismiss(animated: true, completion: nil)
    }

        //MARK:- searchRecords
    @objc func searchRecords(_ textField: UITextField) {
      //  if cityName.isEmpty == true {
        searchCountrie(textField)
        tblCountryList.reloadData()
    /*    }
        if textField.text == countryName[0] {
            searchBar2.isHidden = false
            txtSearchBar.isUserInteractionEnabled = false
            //city[0].country
      /*      self.cityName.removeAll()
        self.countryName.removeAll()
        
            if textField.text?.isEmpty == true {
                tblCountryList.isHidden = true
            }
            if textField.text?.count != 0 {
                tblCountryList.isHidden = false
                for (key,value) in city {
                    if let countrySearch = textField.text {
                        let range = key.lowercased().range(of: countrySearch, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.countryName.append(key)
                        }
                    }
                }                }
                    for (key,value) in city {
                        if textField.text == key as? String {
                            cityName = value
                        }
                    
                      //  cityName.append(value)
                    
                }
                tblCountryList.reloadData()
 */
        }
 */
    }
 
    @objc func searchCityRecord(_ textField: UITextField){
    searchCity(textField)
    }
    func searchCountrie(_ textField: UITextField) {
        //city[0].country
        self.cityName.removeAll()
        self.countryName.removeAll()
        
        if textField.text?.isEmpty == true {
            tblCountryList.isHidden = true
        }
        if textField.text?.count != 0 {
            tblCountryList.isHidden = false
            for (key,value) in city {
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
            if textField.text == key as? String {
                cityName = value
            }
            
            //  cityName.append(value)
            
        }
        tblCountryList.reloadData()
    }
/*
    func searchCountrie(_ textField: UITextField) {
        //city[0].country
        self.cityName.removeAll()
        self.countryName.removeAll()
        
        if textField.text?.isEmpty == true {
            tblCountryList.isHidden = true
        }
        if textField.text?.count != 0 {
            tblCountryList.isHidden = false
            for (key,value) in city {
                if let countrySearch = textField.text {
                    let range = key.lowercased().range(of: countrySearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.countryName.append(key)
                    }
                }
            }                }
        for (key,value) in city {
            if textField.text == key as? String {
                cityName = value
            }
            
            //  cityName.append(value)
            
        }
        tblCountryList.reloadData()
    }
*/
    func searchCity(_ textField: UITextField) {
        //self.cityName.removeAll()
        //self.countryName.removeAll()
        var text = String()
     
        self.cityNameSearch.removeAll()
        if textField.text?.isEmpty == true {
            tblCountryList.isHidden = true
        }
        if textField.text?.count != 0 {
            tblCountryList.isHidden = false
            for name in cityName {
               
                if let countrySearch = textField.text {
                    var countrySearchMutable = countrySearch
                    //countrySearchMutable -= "Bonjour"
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
                    for countrieName in city {
                        if let countryToSearch = textField.text{
                            
                            let range = cityName.key.lowercased().range(of: countryToSearch, options: .literal, range: nil, locale: nil)
                           // let range = cityName.name.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                            if range != nil {
                                self.cityName.append(cityName.cityName)
                                self.countryName.append(cityName.countryName)
                            }
                        }
                    
                    
                }
         /*       for city in city {
                    if let countryToSearch = textField.text{
                        let range = city.name.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                        if range != nil {
                            self.cityName.append(city.name)
                        }
                    }
                }*/
            } else {
                for country in city {
                    cityName.append(country.cityName)
                }
            }
            tblCountryList.reloadData()
        }
*/
    
    func loadJson(fileName: String) -> Cities? {
        if let url = Bundle.main.url(forResource: fileName, withExtension:"json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Cities.self, from: data)
               // print(jsonData.enumerated())
               // print(jsonData.enumerated())
                return jsonData
            } catch {
                print("error")
            }
        }
        //var city = [CityList]()
        return nil
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

extension SettingTableViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if cityName.isEmpty == true {
        return countryName.count
       // } else {
           // return cityNameSearch.count
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomViewCell
        
        cell.textLabel?.text = "\(countryName[indexPath.row]), \(cityName[indexPath.row])"
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        txtSearchBar.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
      //  let vcDestination = UIStoryboard.instantiateViewController(withIdentifier: "WeatherTableViewController")
      //  let detVC = self.storyboard?.instantiateViewController(withIdentifier: "WeatherTableViewController") as! WeatherTableViewController
      //  let VC =
       delegateSaveCityHoliday?.saveCityHolidayRealm(city: txtSearchBar.text!)
        //self.navigationController?.pushViewController(detVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

protocol SaveCityHolidayDelegate {
    func saveCityHolidayRealm(city: String)
}



typealias Cities = [String: [String]]






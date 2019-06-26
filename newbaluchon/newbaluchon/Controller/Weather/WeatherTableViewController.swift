//
//  WeatherTableViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 14/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherTableViewController: UITableViewController {
    
    //var weather: Constant?
    //var realm: Realm!
    //var objectsWeathers = DBManager.sharedInstance.getDataFromDBWeatherHoliday()
    let weather = Weather()
    var sender: UIButton?
    @IBOutlet weak var tableViewWeather: UITableView!

 
    
    var delegate: WeatherTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //realm = try! Realm()
        //DBManager.self
        initSwipeGesture()
        weather.delegateAddCityHoliday = self
        //tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        //tableViewWeather.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableViewWeather.reloadData()
    }

    func initSwipeGesture(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(WeatherTableViewController.swipeForEditing(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //tableView.reloadData()
        return weather.objectsWeathers.count
    }
    /// Validates the selection of a language
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weather1 = weather.objectsWeathers[indexPath.row]
        /*
        if let weather = weather1, let sender = sender {
            delegate?.changeLanguage(language: language)
        }
 */
        dismiss(animated: true, completion: nil)
    }
/*
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    */

    @objc func swipeForEditing(_ sender: UISwipeGestureRecognizer?) {
        if tableView.isEditing == true {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard indexPath.row != 0 else {
                print("impossible")//alerte
                return
            }
            let weatherDelete = weather.objectsWeathers[indexPath.row]
            DBManager.sharedInstance.deleteFromDbWeatherHoliday(object: weatherDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
 
    /*
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: true)
     //print("Company Name : " + names[indexPath.row])
     
     language = Language.list[indexPath.row]
     
     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let newViewController = storyBoard.instantiateViewController(withIdentifier: "TranslateViewController") as! TranslateViewController
     self.present(newViewController, animated: true, completion: nil)
     
     }
     */
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        let weather = self.weather.objectsWeathers[indexPath.row]
        cell.newLabelTitle.text = weather.name
        cell.newLabelDetail.text = weather.temperature
        cell.imageCell.image = UIImage(named: weather.image!)
        
        //cell.detailTextLabel?.text = language.code
        /*
        if let currentLanguage = self.language, currentLanguage.code == language.code {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
 */
        return cell
    }
   /*
    @IBAction func saveToWeatherTableViewController (segue: UIStoryboardSegue) {
        let addCityWeatherViewController = segue.source as! AddCityWeatherUIViewController
        let city = addCityWeatherViewController.cityNameTextField.text
        requestNewCity(city: city!)
        
      
        dismiss(animated: true, completion: nil)
    }

   */
/*
    func requestNewCity(city: String) {
        weather.requestNewCity(city: city)
     tableView.reloadData()
    }
 */
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueSettingHolidayWeather {
            if let vcDestination = segue.destination as? AddCityWeatherUIViewController {
                vcDestination.delegateSaveCityHoliday = self
            }
        }
    }
    
}
protocol WeatherTableViewControllerDelegate {
    /// Change the source or target language
    func changeWeather()
}

extension WeatherTableViewController: SaveCityHolidayDelegate {
    func saveCityHolidayRealm(city: String) {
        weather.requestNewCity(city: city)
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherTableViewController: AddCityHolidayDelegate {
    func itISResultRequestNewCityHoliday(weatherData: WeatherData) {
        DispatchQueue.main.async {
            DBManager.sharedInstance.addDataWeatherHoliday(weather: weatherData)
        }
    }
    
    
    func updateTableViewWeather() {
        self.tableView.reloadData()
    }
}

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var imageCell: UIImageView!
    @IBOutlet weak var newLabelTitle: UILabel!
    @IBOutlet weak var newLabelDetail: UILabel!
    @IBOutlet weak var swipeDelete: UISwipeGestureRecognizer!
}


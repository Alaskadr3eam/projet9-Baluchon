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
      //  realoadrequest()
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
    /// Validates the weatherSelection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.changeWeather(index: indexPath)
        
        
 
        dismiss(animated: true, completion: nil)
    }
/*
    func realoadrequest() {
        for i in 0...weather.objectsWeathers.count - 1 {
            weather.requestNewCityReload(city: weather.objectsWeathers[i].name!, newWeather: weather.objectsWeathers[i], index: i)
            tableViewWeather.reloadData()
        }
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
        guard indexPath.row != 0 else {
            print("impossible")
            return
        }
        if editingStyle == .delete {
            guard indexPath.row != 0 else {
                alertVC(title: "Attention", message: "Cette cellule est celle de la localisation on ne peut pas la supprimer")
                return
            }
            let weatherDelete = weather.objectsWeathers[indexPath.row]
            DBManager.sharedInstance.deleteFromDbWeatherHoliday(object: weatherDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        let weather = self.weather.objectsWeathers[indexPath.row]
        cell.imageCell.contentMode = .scaleAspectFit
        cell.newLabelTitle.text = weather.name
        cell.newLabelDetail.text = ("\(weather.temperature!)°C")
        cell.imageCell.image = UIImage(named: weather.image!)
        changeBackground(index: indexPath.row, cell: cell)
        
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

    func changeBackground(index: Int, cell: WeatherTableViewCell) {
        let letters = CharacterSet.init(charactersIn: "n")
        let range = weather.objectsWeathers[index].image?.rangeOfCharacter(from: letters)
        if range != nil  {
            cell.imageBackground.image = UIImage(named: "ciel nuit")
        } else {
            cell.imageBackground.image = UIImage(named: "ciel jour")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueSettingHolidayWeather {
            if let vcDestination = segue.destination as? SettingTableViewController {
                vcDestination.delegateSaveCityHoliday = self
            }
        }
    }
    
}
protocol WeatherTableViewControllerDelegate: AnyObject {
    /// Change the source or target language
    func changeWeather(index: IndexPath)
}

extension WeatherTableViewController: SaveCityHolidayDelegate {
    func saveCityHolidayRealm(city: String) {
        weather.requestNewCity(city: city)
        dismiss(animated: true, completion: nil)
        tableViewWeather.reloadData()
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
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet weak var newLabelTitle: UILabel!
    @IBOutlet weak var newLabelDetail: UILabel!
    @IBOutlet weak var swipeDelete: UISwipeGestureRecognizer!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
}


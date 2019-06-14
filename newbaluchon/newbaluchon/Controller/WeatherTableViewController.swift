//
//  WeatherTableViewController.swift
//  newbaluchon
//
//  Created by Clément Martin on 14/06/2019.
//  Copyright © 2019 clement. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    //var weather: Constant?
    
    var sender: UIButton?
    
    var delegate: WeatherTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.dataWeatherHoliday.count
    }
    /// Validates the selection of a language
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let weather1 = Constant.dataWeatherHoliday[indexPath.row]
        /*
        if let weather = weather1, let sender = sender {
            delegate?.changeLanguage(language: language)
        }
 */
        dismiss(animated: true, completion: nil)
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
        
        let weather = Constant.dataWeatherHoliday[indexPath.row]
        cell.textLabel?.text = weather.name
        cell.detailTextLabel?.text = "\(weather.temperature)°C"
        cell.imageCell.image = UIImage(named: weather.image)
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
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "choiceLanguage" {
     
     }
     }
     */
}
protocol WeatherTableViewControllerDelegate {
    /// Change the source or target language
    func changeWeather()
}

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var imageCell: UIImageView!
}


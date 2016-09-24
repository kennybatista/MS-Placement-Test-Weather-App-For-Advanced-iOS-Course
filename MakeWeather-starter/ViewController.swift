//
//  ViewController.swift
//  MakeWeather-starter
//
//  Created by Nikolas Burk on 19/09/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import YWeatherAPI

class ViewController: UIViewController {

    var block: [[AnyHashable: Any]] = []
    var lowTemperatureHolder = [String]()
    var highTemperatureHolder = [String]()
    var descriptionHolder = [String]()
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var lowestTemperatureLabel: UILabel!
    @IBOutlet weak var highestTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func goButton(_ sender: UIButton) {
        
        
        YWeatherAPI.sharedManager().fiveDayForecast(forLocation: "New York", success: { (result: [AnyHashable: Any]?) in
//            print(result)
            self.block = result?[AnyHashable("index")] as! [[AnyHashable : Any]]
            
            },
              failure: { (response: Any?, error: Error?) in
              print(error)
            }
        )

        
        
        YWeatherAPI.sharedManager().todaysForecast(forLocation: searchField.text,
            success: { (result: [AnyHashable: Any]?) in
                
                if self.highestTemperatureLabel.text == "" {
                    self.highestTemperatureLabel.text = "No Description Available"
                } else {
                    self.highestTemperatureLabel.text = result?["highTemperatureForDay"] as! String?
                }
                if self.lowestTemperatureLabel.text == "" {
                    self.lowestTemperatureLabel.text = "No Description Available"
                } else {
                    self.lowestTemperatureLabel.text = result?["lowTemperatureForDay"] as! String?
                }
                
                if self.descriptionLabel.text == "" {
                    self.descriptionLabel.text = "No Description Available"
                } else {
                    self.descriptionLabel.text = result?["shortDescription"] as! String?
                }
                
//                print(result)
                
                                
            },
                failure: { (response: Any?, error: Error?) in
                  print(error)
            }
        )
    }
    
   
    
    @IBAction func seeNextFiveDaysLabel(_ sender: UIButton) {
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fiveDays" {
            let destinationController = segue.destination as! ForecastTableViewController
            destinationController.data = self.block
        }
    }
 

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


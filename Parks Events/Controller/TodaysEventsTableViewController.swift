//
//  TodaysEventsTableViewController.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/12/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TodaysEventsTableViewController: UITableViewController {

    var test = ["cookie", "monster", "big", "bird"]
    var apiURL = "https://data.cityofnewyork.us/resource/fudw-fgrp.json?date="
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let someDateTime = formatter.string(from: date)
        apiURL.append(someDateTime)
        workingOnIt()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = test[indexPath.row]

        return cell
    }
    
    func workingOnIt() {
        
        Alamofire.request(apiURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                print(response.result.value!)
                
            }
            
        }
    }
}

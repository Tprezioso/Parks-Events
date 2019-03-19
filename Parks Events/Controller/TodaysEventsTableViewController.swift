//
//  TodaysEventsTableViewController.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/12/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit

class TodaysEventsTableViewController: UITableViewController {

    var apiURL = "https://data.cityofnewyork.us/resource/fudw-fgrp.json?date="
    let date = Date()
    var eventsArray = [[String : String]]()
    private let apiCall = APICalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDateForURL()
        getParksEvent()
        
    }
    
    func getDateForURL() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let someDateTime = formatter.string(from: date)
        apiURL.append(someDateTime)

    }
    
    func getParksEvent() {
        DispatchQueue.main.async {
            self.apiCall.currentDayEventsCall(url: self.apiURL) { (json) in
                self.eventsArray = json!
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = eventsArray[indexPath.row]["title"]

        return cell
    }
    
}

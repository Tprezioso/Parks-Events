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
    @objc var refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodaysDateForURL(date: date)
        getParksEvent()
        refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshController)

    }
    
    @objc func refresh(_ sender: Any) {
        getTodaysDateForURL(date: date)
        getParksEvent()
    }
    
    func getTodaysDateForURL(date: Date) {
        self.apiURL = "https://data.cityofnewyork.us/resource/fudw-fgrp.json?date="
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let someDateTime = formatter.string(from: date)
        apiURL.append(someDateTime)
    }
    
    func getParksEvent() {
        DispatchQueue.main.async {
            self.apiCall.currentDayEventsCall(url: self.apiURL) { (json) in
                self.eventsArray = [["" : ""]]
                self.eventsArray = json!
                print(self.eventsArray)
                if self.eventsArray == [] as! [[String : String]] {
                    self.navigationItem.title = "No Events Today"
                } else {
                    self.navigationItem.title = "Todays Park Events"
                }
                
                if self.refreshController.isRefreshing {
                    self.refreshController.endRefreshing()
                }

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
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        let myDatePicker: UIDatePicker = UIDatePicker()
        // setting properties of the datePicker
        myDatePicker.timeZone = NSTimeZone.local
        
        myDatePicker.frame = CGRect(origin: CGPoint(x: 0,y :15), size: CGSize(width: 270, height: 200))
        
        myDatePicker.datePickerMode = UIDatePicker.Mode.date
        
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.view.addSubview(myDatePicker)
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            DispatchQueue.main.async {
                self.getTodaysDateForURL(date: myDatePicker.date)
                self.getParksEvent()
                
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailTableViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        detailViewController.detailEventArray = eventsArray[index]
    }
    
}

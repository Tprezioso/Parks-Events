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
                print(self.eventsArray)
                if self.eventsArray == [] as! [[String : String]] {
                    self.navigationItem.title = "No Events Today"
                } else {
                    self.navigationItem.title = "Park Events"
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let selectedDate = dateFormatter.string(from: myDatePicker.date)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.view.addSubview(myDatePicker)
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    
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

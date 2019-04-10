//
//  TodaysEventsTableViewController.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/12/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit
import Kanna

class TodaysEventsTableViewController: UITableViewController {

    // MARK: - Global Properties
    var itemForURLSearch = ""
    let date = Date()
    var eventsArray = [[String : String]]()
    private let apiCall = APICalls()
    @objc var refreshController = UIRefreshControl()
    var arrayForEvents = [""]
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodaysDateForURL(date: date)
        getParksEvent()
        refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshController)

    }
    
    // MARK: - Pull to Refresh
    @objc func refresh(_ sender: Any) {
        getTodaysDateForURL(date: date)
        getParksEvent()
    }
    
    // MARK: - Convert Date for API Call
    func getTodaysDateForURL(date: Date) {
        itemForURLSearch = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let someDateTime = formatter.string(from: date)
        
        let newDate = Date()
        
        if formatter.string(from: newDate) != someDateTime {
            navigationItem.title = someDateTime
        } else {
            navigationItem.title = "Todays Park Events"
        }

        itemForURLSearch.append(someDateTime)
            self.apiCall.scrapeNYCParksEvent(date: someDateTime) { (json) in
                self.arrayForEvents = json
                print(">>>>>>>>>>>>>>>>>>\(json)")
            }



    }
    
    // MARK: - API Call
    func getParksEvent() {
        DispatchQueue.main.async {
            self.apiCall.currentDayEventsCall(searchID: self.itemForURLSearch) { (json) in
                self.eventsArray = [["" : ""]]
                self.eventsArray = json!

                if self.eventsArray == [] as! [[String : String]] {
                    self.navigationItem.title = "No Events Today"
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
    
    // MARK: - Action(s)
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        let searchDatePicker: UIDatePicker = UIDatePicker()

        searchDatePicker.timeZone = NSTimeZone.local
        searchDatePicker.frame = CGRect(origin: CGPoint(x: 0,y :15), size: CGSize(width: 270, height: 200))
        searchDatePicker.datePickerMode = UIDatePicker.Mode.date
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.view.addSubview(searchDatePicker)
       
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            DispatchQueue.main.async {
                self.getTodaysDateForURL(date: searchDatePicker.date)
                self.getParksEvent()
                
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
    
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailTableViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        
        detailViewController.detailEventArray = eventsArray[index]
    }
        
}

//
//  DetailTableViewController.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/31/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit

class detailCell: UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!

}

class DetailTableViewController: UITableViewController {

    // MARK: - Global Properties
    var detailEventArray = [String : String]()
    var eventDetails = [String]()
    private let apiCall = APICalls()
    var imageID = ""
    var eventimageArray = [[String : String]]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>>>>>>>>>>>>>>>>>>>>>> \(detailEventArray)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        setUpArray()
        getImageForEvent()

    }
    
    // MARK: - Image API Call
    func getImageForEvent() {
        DispatchQueue.main.async {
            self.apiCall.imageForEvent(imageID: self.imageID, completion: { (json) in
//                self.eventimageArray = [["" : ""]]
//                self.eventimageArray = json!
                print(json ?? "NO IMAGE")
            })
        }
    }
    
    // MARK: - Setup Array for Display
    func setUpArray()  {
        imageID = (detailEventArray["event_id"] ?? "No ID")
        print(imageID)
        eventDetails.append(detailEventArray["title"] ?? "No Title")
        eventDetails.append(detailEventArray["start_time"] ?? "No Start Time")
        eventDetails.append(detailEventArray["end_time"] ?? "No End Time")
        eventDetails.append(detailEventArray["description"] ?? "No Description" )
        eventDetails.append(detailEventArray["cost_description"] ?? "No Cost")
        eventDetails.append(detailEventArray["location_description"] ?? "No Location")
        eventDetails.append(detailEventArray["url"] ?? "No URL" )
//        print(eventDetails)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailEventCell", for: indexPath) as! detailCell
        cell.detailLabel?.text = eventDetails[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

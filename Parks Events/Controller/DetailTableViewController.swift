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

    var detailEventArray = [String : String]()
    var eventDetails = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(">>>>>>>>>>>>>>>>>>>>>>>> \(detailEventArray)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        setUpArray()
    }
    
    func setUpArray()  {
        eventDetails.append(detailEventArray["title"] ?? "No Title")
        eventDetails.append(detailEventArray["start_time"] ?? "No Start Time")
        eventDetails.append(detailEventArray["end_time"] ?? "No End Time")
        eventDetails.append(detailEventArray["description"] ?? "No Description" )
        eventDetails.append(detailEventArray["cost_description"] ?? "No Cost")
        eventDetails.append(detailEventArray["location_description"] ?? "No Location")
        eventDetails.append(detailEventArray["url"] ?? "No URL" )
        print(eventDetails)
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

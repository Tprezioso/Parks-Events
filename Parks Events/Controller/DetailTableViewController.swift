//
//  DetailTableViewController.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/31/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import UIKit
import ParallaxHeader

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
//        print(">>>>>>>>>>>>>>>>>>>>>>>> \(detailEventArray)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        setUpArray()
        getImageForEvent()
        
//        let bar:UINavigationBar! =  self.navigationController?.navigationBar
//        self.title = "Whatever..."
//        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        bar.shadowImage = UIImage()
//        bar.alpha = 0.0
    }
    
    // MARK: - Image API Call
    func getImageForEvent() {
        DispatchQueue.main.async {
            self.apiCall.imageForEvent(imageID: self.imageID, completion: { (json) in
                self.eventimageArray = [["" : ""]]
                self.eventimageArray = json!
                print(json ?? "NO IMAGE")
                if json != [] {
                    let url = URL(string: self.eventimageArray[0]["path_2"]!)!
                    let data = try? Data(contentsOf: url)
                    
                    if let imageData = data {
                        let imageView = UIImageView()
                        imageView.image = UIImage(data: imageData)
                        imageView.contentMode = .scaleAspectFit
                        
                        self.tableView.parallaxHeader.view = imageView
                        self.tableView.parallaxHeader.height = 400
                        self.tableView.parallaxHeader.minimumHeight = 0
                        self.tableView.parallaxHeader.mode = .fill
                    }

                }
                

            })
        }
    }
    
    // MARK: - Setup Array for Display
    func setUpArray()  {
        let detailsForDisplay = ["title","start_time","end_time","description","cost_description","location_description","url",]
        
        imageID = (detailEventArray["event_id"] ?? "No ID")
        print(imageID)

        for detail in detailsForDisplay {
            eventDetails.append(detailEventArray["\(detail)"] ?? "No Data")
        }
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

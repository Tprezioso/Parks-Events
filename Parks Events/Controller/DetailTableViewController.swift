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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>>>>>>>>>>>>>>>>>>>>>> \(detailEventArray)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return detailEventArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailEventCell", for: indexPath) as! detailCell
        cell.detailLabel?.text = Array(self.detailEventArray.values)[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

//
//  APICalls.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/18/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APICalls {

    typealias WebServiceResponse = ([[String: String]]?) -> Void
    
    let headers: HTTPHeaders = [
        
        "X-App-Token": MY_API_KEY,
        "Accept": "application/json"
    ]
    
    func currentDayEventsCall(url: String, completion: @escaping WebServiceResponse) {
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                if let eventJSON = response.result.value! as? [[String: String]] {
                    completion(eventJSON)
                }
            }
            
        }
    }

}


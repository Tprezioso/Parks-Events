//
//  APICalls.swift
//  Parks Events
//
//  Created by Thomas Prezioso on 3/18/19.
//  Copyright © 2019 Thomas Prezioso. All rights reserved.
//

import Foundation
import Alamofire

func currentDayEventsCall(url: String) {
    Alamofire.request(url, method: .get).responseJSON { (response) in
        if response.result.isSuccess {
            print(response.result.value!)
            
        }
        
    }

}

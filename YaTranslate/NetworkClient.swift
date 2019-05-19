//
//  NetworkClient.swift
//  YaTranslate
//
//  Created by Denis Tkachev on 19/05/2019.
//  Copyright © 2019 Denis Tkachev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkClient {
    typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void
    
    func execute(_ url: URL, completion: @escaping WebServiceResponse){
        Alamofire.request(url).validate().responseJSON { response in
            if let error = response.error {
                completion(nil, error)
            } else if let jsonArray = response.result.value as? [[String: Any]] {
                completion(jsonArray, nil)
            } else if let jsonDict = response.result.value as? [String: Any] {
                completion([jsonDict], nil)
            }
        }
    }
}

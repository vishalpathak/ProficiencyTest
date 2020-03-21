//
//  NetworkService.swift
//  ProficiencyTest
//
//  Created by VishalP on 21/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation
import Alamofire


class NetworkService: NSObject{
    
    static func getDataFromAPI<T: Decodable>(_ apiURL: String, completion: @escaping (T?, _ error:Error?) -> Void){
        
        AF.request(apiURL)
            .response { (response) in
                guard let data = response.data else {
                    completion(nil, response.error)
                    return
                }
                do{
                    let str = String(decoding: data, as: UTF8.self)
                    let dd = str.data(using: .utf8)
                    if let dt = dd{
                        let jsonObj = try JSONDecoder().decode(T.self, from: dt)
                        completion(jsonObj, nil)
                    }
                }catch{
                    completion(nil, error)
                }
        }
    }
}

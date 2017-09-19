//
//  FetchDataManager.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class FetchDataManager {
    
    class func GETWeather(completion: @escaping (_ response: CityWeather?, _ error: Error?) -> ()) {
        self.makeRequest(completion: completion)
    }
    
    private class func makeRequest(completion: @escaping (_ response: CityWeather?, _ error: Error?) -> ()) {
        let url = URL(string: URLManager.urlForWeatherData())
        Alamofire.request(url!).responseObject { (response: DataResponse<CityWeather>) in
            if let error = response.error {
                completion(nil, error)
            } else {
                if let weather = response.result.value {
                    do {
                        try RealmManager.addOrUpdate(object: weather)
                        completion(weather, nil)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

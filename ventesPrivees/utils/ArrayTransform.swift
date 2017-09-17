//
//  ArrayTransform.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import RealmSwift
import ObjectMapper

class ArrayTransform<T:RealmSwift.Object> : TransformType where T:Mappable {
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let realmList = List<T>()
        
        if let jsonArray = value as? Array<Any> {
            for item in jsonArray {
                if let realmModel = Mapper<T>().map(JSONObject: item) {
                    realmList.append(realmModel)
                }
            }
        }
        return realmList
    }
    
    func transformToJSON(_ value: List<T>?) -> Array<AnyObject>? {
        
        guard let realmList = value, realmList.count > 0 else { return nil }
        
        var resultArray = Array<T>()
        
        for entry in realmList {
            resultArray.append(entry)
        }
        
        return resultArray
    }
}

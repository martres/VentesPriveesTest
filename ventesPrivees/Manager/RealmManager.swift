//
//  RealmManager.swift
//  ventesPrivees
//
//  Created by Martreux Steven on 15/09/2017.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    //MARK: - Get functions
    
    class func get<T>(objectType: T.Type, forPrimaryKey key: AnyObject) throws -> T? where T:Object {
        return try Realm().object(ofType: objectType, forPrimaryKey: key)
    }
    
    class func get<T>(objectType: T.Type, filter: String? = nil) throws -> Results<T> where T:Object {
        var result = try Realm().objects(objectType)
        
        if let filter = filter , filter != ""{
            result = result.filter(filter)
        }
        return result
    }
    
    
    
    //MARK: - Add functions
    
    class func add<T>(object: T) throws where T:Object {
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
    }
    
    class func add<T>(objects: [T]) throws where T:Object {
        let realm = try Realm()
        try realm.write {
            realm.add(objects)
        }
    }
    
    
    //MARK: - Update
    //
    
    class func addOrUpdate<T>(object: T) throws where T:Object {
        if let idName = T.primaryKey(),
            let id = object.value(forKey: idName),
            let _ = try get(objectType : T.self, forPrimaryKey: id as AnyObject)
        {
            try update(type: T.self, changes: getPropertiesUpdating(object: object))
        }
        else {
//            DispatchQueue.global(qos: .background).async {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(object, update: true)
                }
//            }
        }
    }
    
    class func addOrUpdate<T>(objects: [T]) throws where T:Object {
        for object in objects {
            try addOrUpdate(object : object)
        }
    }
    
    class func update<T>(type: T.Type, changes: [String: AnyObject]) throws where T:Object {
        let realm = try Realm()
        try realm.write {
            realm.create(type, value: changes, update: true)
        }
    }
    
    class func update<T>(type: T.Type, changes: [String: AnyObject], realm: Realm) where T:Object {
        realm.create(type, value: changes, update: true)
    }
    
    class func synchronize<T>(objects: [T]) throws where T:Object {
        guard let id = T.primaryKey() else { return }
        
        let objExisting = try get(objectType : T.self)
        
        var Ids : [AnyObject] = []
        for item in objects {
            let id = item[id]
            Ids.append(id as AnyObject)
        }
        let objectAddUpdate = objects.filter { !objExisting.contains($0) }
        let objectDel = objExisting.filter(NSPredicate(format: "NOT (id IN %@)", Ids))
        let realm = try Realm()
        
        realm.beginWrite()
        for object in objectAddUpdate {
            update(type: T.self, changes: getPropertiesUpdating(object: object), realm: realm)
        }
        realm.delete(objectDel)
        try realm.commitWrite()
    }
    
    
    //MARK: - Delete
    
    
    class func deleteAll() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
    
    class func deleteObjects<T>(objects: Results<T>) throws where T:Object {
        let realm = try Realm()
        try realm.write {
            realm.delete(objects)
        }
    }
    
    //MARK: - Tools
    
    class func getPropertiesUpdating<T>(object: T) -> [String: AnyObject] where T:Object {
        var properties = [String:AnyObject]()
        for property in object.objectSchema.properties {
            properties[property.name] = object.value(forKey: property.name) as AnyObject?
        }
        return properties
    }
    
    class func getObjectResult<T>(object : T.Type) throws -> Results<T> where T:Object{
        let realm = try Realm()
        return realm.objects(object)
    }    
}

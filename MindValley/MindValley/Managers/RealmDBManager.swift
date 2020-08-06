//
//  RealmDBManager.swift
//  MindValley
//
//  Created by Ramesh B on 26/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation
import RealmSwift

/// Database manager: A singleton class where helps to fetch the cached data and to store the new data in the data base
class RealmManager {
    
    // MARK: Properties
    static let sharedInstance = RealmManager()
    private var realmReference: Realm?
    private var encryptedRealmReference: Realm?
    
    // MARK: Intialiser
    private init() {
        do {
            let config = Realm.Configuration()
            Realm.Configuration.defaultConfiguration = config
            realmReference = try Realm(configuration: config)
            
        } catch _ {}
    }
    
    
    func realmRef() -> Realm {
        return realmReference!
    }
    
    // It helps to save the realm objects in to the database
    func saveObject(object: CacheableEntity) -> Bool {
        do {
            try self.realmRef().write {
                self.realmRef().add(object)
              }
        } catch {
            return false
        }
        return true
    }
    
}

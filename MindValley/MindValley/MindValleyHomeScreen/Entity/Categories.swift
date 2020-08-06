//
//  Categories.swift
//  MindValley
//
//  Created by Ramesh B on 24/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CacheableEntity: Object, Codable {}

@objcMembers class Categories: CacheableEntity {
    @objc dynamic var categoryList: CategoryList?
    dynamic var mindValleyCategories: String = ""
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "data"
    }
    
    override static func primaryKey() -> String? {
        return "mindValleyCategories"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categoryList = try container.decode(CategoryList.self, forKey: .categoryList)
        super.init()
    }
}

@objcMembers class CategoryList: Object, Codable {
    let  categoriess: List<Category> = List<Category>()
    enum CodingKeys: String, CodingKey {
        case categoriess = "categories"
    }
    
    required init(){
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let trackList = try container.decode([Category].self, forKey: .categoriess)
        categoriess.append(objectsIn: trackList)
        super.init()
    }
}

@objcMembers class Category: Object, Codable {
    dynamic var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        super.init()
    }
}

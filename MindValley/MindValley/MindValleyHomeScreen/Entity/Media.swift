//
//  Media.swift
//  MindValley
//
//  Created by Ramesh B on 26/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Media: CacheableEntity {
    @objc dynamic var data: MediaList?
    dynamic var mindValleyMedia: String = ""
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    override static func primaryKey() -> String? {
        return "mindValleyMedia"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(MediaList.self, forKey: .data)
        super.init()
    }
}

@objcMembers class MediaList: Object, Codable {
    
    let  media: List<MediaChannel> = List<MediaChannel>()
    enum CodingKeys: String, CodingKey {
        case media = "media"
    }
    
    required init(){
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let channelList = try container.decode([MediaChannel].self, forKey: .media)
        media.append(objectsIn: channelList)
        super.init()
    }
}

@objcMembers class MediaChannel: Object, Codable {
    dynamic var type: String?
    dynamic var title: String?
    dynamic var coverAsset: CoverAsset?
    dynamic var channel: MChannel?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
        case channel = "channel"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        coverAsset = try container.decode(CoverAsset.self, forKey: .coverAsset)
        channel = try container.decode(MChannel.self, forKey: .channel)
        super.init()
    }
}

@objcMembers class MChannel: Object, Codable {
    dynamic var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        super.init()
    }
}

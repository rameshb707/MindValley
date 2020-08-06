//
//  Channels.swift
//  MindValley
//
//  Created by Ramesh B on 25/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Channels: CacheableEntity {
    @objc dynamic var data: ChannelList?
    dynamic var mindValleyChannels: String = ""
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    override static func primaryKey() -> String? {
        return "mindValleyChannels"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(ChannelList.self, forKey: .data)
        super.init()
    }
}

@objcMembers class ChannelList: Object, Codable {
    
    let  channels: List<Channel> = List<Channel>()
    enum CodingKeys: String, CodingKey {
        case channels = "channels"
    }
    
    required init(){
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let channelList = try container.decode([Channel].self, forKey: .channels)
        channels.append(objectsIn: channelList)
        super.init()
    }
}

@objcMembers class Channel: CacheableEntity {
    dynamic var title: String?
    let series: List<Series> = List<Series>()
    dynamic var mediaCount: Int = 0
    let  latestMedia: List<LatestMedia> = List<LatestMedia>()
    dynamic var coverAsset: CoverAsset?
    @objc dynamic var iconAsset: IconAsset?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case series = "series"
        case mediaCount = "mediaCount"
        case latestMedia = "latestMedia"
        case coverAsset = "coverAsset"
        case iconAsset = "iconAsset"
        
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        let seriesList = try container.decode([Series].self, forKey: .series)
        series.append(objectsIn: seriesList)
        mediaCount = try container.decode(Int.self, forKey: .mediaCount)

        let latestMediaList = try container.decode([LatestMedia].self, forKey: .latestMedia)
        latestMedia.append(objectsIn: latestMediaList)
        //        iconAsset = try container.decode(IconAsset.self, forKey: .iconAsset)

        coverAsset = try container.decode(CoverAsset.self, forKey: .coverAsset)

        super.init()
    }
}

@objcMembers class LatestMedia: Object, Codable {
    dynamic var type: String?
    dynamic var title: String?
    dynamic var coverAsset: CoverAsset?
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        coverAsset = try container.decode(CoverAsset.self, forKey: .coverAsset)
        super.init()
    }
}

@objcMembers class Series: Object, Codable {
    dynamic var title: String?
    dynamic var coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case coverAsset = "coverAsset"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        coverAsset = try container.decode(CoverAsset.self, forKey: .coverAsset)

        super.init()
    }
}

@objcMembers class CoverAsset: Object, Codable {
    dynamic var url: String?

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        super.init()
    }
}

@objcMembers class IconAsset: Object, Codable {
    dynamic var thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "thumbnailUrl"
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        super.init()
    }
}

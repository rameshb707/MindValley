//
//  MindValleyHomeSectionBuilder.swift
//  MindValley
//
//  Created by Ramesh B on 29/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation

/// The role of this enumeration is to capture the data and submit to the section to crate the items to populate
enum MindValleySectionModel {
    case MVNewEpisiodes(Media)
    case MVCategories(Categories)
    case NewChannel(Channel)
}

/// This caries the neccessary information to create the sections with items along with te cell identifier
struct MindValleySection {
    let cellIdentifier: String
    let cellModel: MindValleySectionModel
}


extension MindValleySection {
     /// The static function used to create the new section with the data assciacted and appending to the table view to create show the channels or series or catergories in given order
    ///
    /// - Parameter MindValleySectionModel: Enum which hold the section information
    /// - returns: MindValleySection New build section using the MindValleySectionModel
    static func buildSections(entity: MindValleySectionModel) -> MindValleySection? {
        switch entity {
        case .MVNewEpisiodes(let media):
            let mediaSection = MindValleySection(cellIdentifier:NewEpisodesCollectionViewCell.identifier, cellModel: .MVNewEpisiodes(media))
            return mediaSection
            
        case .MVCategories(let categorie):
            let categorySection = MindValleySection(cellIdentifier:MindValleyCategoryCollectionViewCell.identifier, cellModel: .MVCategories(categorie))
            return categorySection
            
        case .NewChannel(let channel):
            if channel.series.isEmpty{
               let channelSection = MindValleySection(cellIdentifier:ChannelsCollectionViewCell.identifier, cellModel: .NewChannel(channel))
                return channelSection
            } else {
               let seriesSection = MindValleySection(cellIdentifier:SeriesCollectionViewCell.identifier, cellModel: .NewChannel(channel))
                return seriesSection
            }
        }
    }
}

//
//  NewEpisodesCollectionViewCell.swift
//  MindValley
//
//  Created by Ramesh B on 28/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit
import Kingfisher

class NewEpisodesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: NewEpisodesCollectionViewCell.self)
    @IBOutlet weak var mindValleyCourseImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var channelText: UILabel!

    
    func loadNewEpisodes(media: MediaChannel) {
        if let coverAsset =  media.coverAsset?.url, let url = URL(string: coverAsset) {
            mindValleyCourseImageView.kf.setImage(with: url)
        }
        if let mediaTitle = media.title {
            title.text = mediaTitle
        }
        if let discription = media.channel?.title {
            channelText.text = discription
        }
    }
}

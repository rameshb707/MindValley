//
//  ChannelsCollectionViewCell.swift
//  MindValley
//
//  Created by Ramesh B on 28/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit

class ChannelsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ChannelsCollectionViewCell.self)

    @IBOutlet weak var channelSeriesImageHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var channelOrSeriesImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    

    func loadChannels(latestMedia: LatestMedia) {
        if let coverAsset =  latestMedia.coverAsset?.url, let url = URL(string: coverAsset) {
            channelOrSeriesImageView.kf.setImage(with: url)
        }
        if let mediaTitle = latestMedia.title {
            title.text = mediaTitle
        }
    }
}

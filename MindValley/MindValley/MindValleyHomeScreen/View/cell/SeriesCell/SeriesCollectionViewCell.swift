//
//  SeriesCollectionViewCell.swift
//  MindValley
//
//  Created by Ramesh B on 28/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit
import Kingfisher

class SeriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var seriesImageView: UIImageView!
    
    static let identifier = String(describing: SeriesCollectionViewCell.self)

    func loadSeries(series: Series) {
        if let coverAsset =  series.coverAsset?.url, let url = URL(string: coverAsset) {
            seriesImageView.kf.setImage(with: url)
        }
        if let mediaTitle = series.title {
            seriesTitle.text = mediaTitle
        }
    }

}

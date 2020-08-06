//
//  MindValleyCategorySectionCell.swift
//  MindValley
//
//  Created by Ramesh B on 27/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit
import Foundation

class MindValleySectionCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewTraillingConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var episodesCount: UILabel!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var seperatorView: UIView!
    
    // MARK: Properties
    static let identifier = String(describing: MindValleySectionCell.self)
    var section: MindValleySection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        channelIcon.layer.cornerRadius = channelIcon.bounds.size.height/2
        registerNib()
    }
    
    // Registers the collection view cells
    private func registerNib() {
        categoriesCollectionView.register(UINib(nibName: MindValleyCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MindValleyCategoryCollectionViewCell.identifier)
        categoriesCollectionView.register(UINib(nibName: NewEpisodesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewEpisodesCollectionViewCell.identifier)
        categoriesCollectionView.register(UINib(nibName: ChannelsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChannelsCollectionViewCell.identifier)
        categoriesCollectionView.register(UINib(nibName: SeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
    }
    
    /// It loads the segregates the section based on the Object type helps collection view to load contents and reload
    func loadSection(data: MindValleySection?) {
        switch data?.cellModel {
        case .MVCategories:
            self.sectionTitle.text = Constants.categoriesTitle
            showRequiredUIElements(show: true)
            seperatorView.isHidden = true
        case .MVNewEpisiodes:
            self.sectionTitle.text = Constants.mediaTitle
            showRequiredUIElements(show: true)
        case .NewChannel(let channel):
            self.channelTitle.text = channel.title
            self.episodesCount.text =  (channel.series.isEmpty) ? "\(channel.latestMedia.count) episodes" : "\(channel.series.count) series"
            showRequiredUIElements(show: false)
        default:
            break
        }
        self.section = data
        self.categoriesCollectionView.reloadData()
    }
    
    private func showRequiredUIElements(show: Bool) {
        sectionTitle.isHidden = !show
        channelTitle.isHidden = show
        episodesCount.isHidden = show
        channelIcon.isHidden = show
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension MindValleySectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mindValleySection = self.section else { return 0 }
        switch mindValleySection.cellModel {
        case .MVCategories(let categorie):
            return categorie.categoryList?.categoriess.count ?? 0
        case .MVNewEpisiodes(let media):
            return media.data?.media.count ?? 0
        case .NewChannel(let channel):
            return (channel.series.isEmpty) ? channel.latestMedia.count : channel.series.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mindValleySection = self.section else { return UICollectionViewCell()  }
        switch mindValleySection.cellModel {
        case .MVNewEpisiodes(let media):
            if let media = media.data?.media {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mindValleySection.cellIdentifier, for: indexPath) as? NewEpisodesCollectionViewCell
                cell?.loadNewEpisodes(media: media[indexPath.row])
                cell?.mindValleyCourseImageView.layer.cornerRadius = 10
                cell?.mindValleyCourseImageView.layer.masksToBounds = true
                return cell!
            }
        case .MVCategories(let categories):
            if let category = categories.categoryList?.categoriess {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mindValleySection.cellIdentifier, for: indexPath) as? MindValleyCategoryCollectionViewCell
                cell?.categoryName.text = category[indexPath.row].name
                cell?.layer.cornerRadius = 30
                return cell!
            }
        case .NewChannel(let channel):
            if !channel.series.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mindValleySection.cellIdentifier, for: indexPath) as? SeriesCollectionViewCell
                cell?.loadSeries(series: channel.series[indexPath.row])
                return cell!
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mindValleySection.cellIdentifier, for: indexPath) as? ChannelsCollectionViewCell
                cell?.loadChannels(latestMedia: channel.latestMedia[indexPath.row])
                return cell!
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let mindValleySection = self.section else { return CGSize() }
        switch mindValleySection.cellModel {
        case .MVNewEpisiodes:
            return CGSize(width: (UIScreen.main.bounds.size.width/2 - 20), height: collectionView.bounds.size.height)
        case .MVCategories:
            return CGSize(width: (UIScreen.main.bounds.size.width - (collectionViewLeadingConstant.constant + collectionViewTraillingConstant.constant + 10))/2, height: 60)
        case .NewChannel(let channel):
            if channel.series.isEmpty {
                return CGSize(width: (UIScreen.main.bounds.size.width/2.3), height: collectionView.bounds.size.height)
            } else {
                return CGSize(width: (UIScreen.main.bounds.size.width/1.2), height: collectionView.bounds.size.height)
            }
        }
    }
}

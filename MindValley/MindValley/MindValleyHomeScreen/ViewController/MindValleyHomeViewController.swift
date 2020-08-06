//
//  MindValleyHomeViewController.swift
//  MindValley
//
//  Created by Ramesh B on 27/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit

protocol MindValleyHomeView :NSObjectProtocol{
    func displayCategories(categorie: MindValleySectionModel)
    func displayMedia(media: MindValleySectionModel)
    func displayChannels(channel: [MindValleySectionModel])
    func displayLoadingIndicator()
    func stopLoadingIndicatior()
}

class MindValleyHomeViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var mindValleyHomeTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var presenter: MindValleyHomePresenter!
    var sections: [(Int, MindValleySection)] =  [(Int, MindValleySection)]() {
        didSet {
            self.sections.sort{$0.0 < $1.0}
            self.mindValleyHomeTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mindValleyHomeTableView?.register(UINib(nibName: MindValleySectionCell.identifier, bundle: nil), forCellReuseIdentifier: MindValleySectionCell.identifier)
        MindValleyHomeConfigurator.sharedInstance.configure(viewController: self)
        presenter.getMindValleyData()
    }
}

// MARK: UITableViewDelegate and UITableViewDataSource
extension MindValleyHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.sections[indexPath.row].1
        let cell = tableView.dequeueReusableCell(withIdentifier: MindValleySectionCell.identifier, for: indexPath) as? MindValleySectionCell
        cell?.loadSection(data: item)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.sections[indexPath.row].1
        switch item.cellModel {
        case .MVCategories(let categorie):
            return (CGFloat(((categorie.categoryList?.categoriess.count ?? 0)/2)) * CGFloat(90.0))
        case .MVNewEpisiodes:
            return Constants.mediaSectionHeightConstant
        case .NewChannel(let channel):
            return (channel.series.isEmpty) ? Constants.mediaSectionHeightConstant : Constants.seriesSectionHeightConstant 
        }
    }
    
}

extension MindValleyHomeViewController: MindValleyHomeView {
    
    func displayMedia(media: MindValleySectionModel) {
        if let mediaSection = MindValleySection.buildSections(entity: media) {
            self.sections.append((1, mediaSection))
        }
        loadingIndicator?.stopAnimating()
    }
    
    func displayCategories(categorie: MindValleySectionModel) {
        if let categorieSection = MindValleySection.buildSections(entity: categorie) {
            self.sections.append((3, categorieSection))
        }
    }
    
    func displayChannels(channel: [MindValleySectionModel]) {
        for addNewSection in channel {
            if let channelSection = MindValleySection.buildSections(entity: addNewSection) {
                self.sections.append((2, channelSection))
            }
        }
        loadingIndicator?.stopAnimating()
    }
    
    func displayLoadingIndicator() {
        loadingIndicator?.startAnimating()
    }
    
    func stopLoadingIndicatior() {
        loadingIndicator?.stopAnimating()
    }
}

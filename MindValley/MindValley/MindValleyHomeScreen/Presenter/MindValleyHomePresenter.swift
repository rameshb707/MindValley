//
//  MindValleyPresenter.swift
//  MindValley
//
//  Created by Ramesh B on 27/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation
/// The interface which helps to communicate between interactor and the view
protocol MindValleyHomePresenterInterface {
    func getMindValleyData()
    func presentMedia(media: MindValleySectionModel)
    func presentChannel(channels: [MindValleySectionModel])
    func presentCategories(categories: MindValleySectionModel)
    func failToSaveInDB()
    func errorWhileFetching()
    func displayLoadingIndicator()
}

/// The responsibility of this presenter is to listen from the user interaction and call interactor to perform bussines loic  and display the content which is avalibale from the interactor to view
class MindValleyHomePresenter: MindValleyHomePresenterInterface {
    weak var viewController: MindValleyHomeView!
    var interactor: MindValleyHomeInteractor!

    func getMindValleyData() {
        interactor.getMindValleyData()
    }
    
    func presentMedia(media: MindValleySectionModel) {
        viewController.displayMedia(media: media)
    }
    
    func presentChannel(channels: [MindValleySectionModel]) {
        viewController.displayChannels(channel: channels)
    }
    
    func presentCategories(categories: MindValleySectionModel) {
        viewController.displayCategories(categorie: categories)
    }
    
    func displayLoadingIndicator() {
        viewController.displayLoadingIndicator()
    }
    
    func failToSaveInDB() {
        viewController.stopLoadingIndicatior()
    }
    func errorWhileFetching() {
        viewController.stopLoadingIndicatior()
    }


}


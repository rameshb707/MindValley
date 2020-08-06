//
//  MindValleyHomeInteractor.swift
//  MindValley
//
//  Created by Ramesh B on 27/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit

protocol MindValleyHomeInteractorInterface {
    func getMindValleyData()
    func getMedia()
    func getCategories()
    func getChannels()
}

/// - Interactor which handles all the  bussiness logic and based on user interaction with view presenter ask interactor and interactor guides worker and reply back presneter to perform there duties
/// - Initially it checks the Database whether required data is available or not.
/// - If dat is avaliable it will ask presenter to display
/// - Else, it will ask worker to get the data form server
/// - Once the callback is recieved from the worker it will save it to database and then it tells presenter to display.
final class MindValleyHomeInteractor: MindValleyHomeInteractorInterface {
    
    // MARK: Properties
    let realm = RealmManager.sharedInstance.realmRef()
    var worker = MindValleyHomeWorker()
    var presenter: MindValleyHomePresenterInterface!
    var sections: [MindValleySectionModel] = [MindValleySectionModel]()
    
    func getMindValleyData() {
        self.getMedia()
        self.getCategories()
        self.getChannels()
    }
    
    func getMedia() {
        let media = realm.objects(Media.self)
        if media.isEmpty {
            presenter.displayLoadingIndicator()
            worker.callMedia(completionHandler: {[weak self] (media, error) in
                DispatchQueue.main.async {
                    if let cacheableObject = media {
                        if RealmManager.sharedInstance.saveObject(object: cacheableObject) {
                            let mediaModel = MindValleySectionModel.MVNewEpisiodes(cacheableObject)
                            self?.presenter.presentMedia(media: mediaModel)
                        } else {
                            self?.presenter.failToSaveInDB()
                        }
                    } else {
                        self?.presenter.errorWhileFetching()
                    }
                }
            })
        } else {
            if let cachedMediaObject  = media.first {
                let mediaModel = MindValleySectionModel.MVNewEpisiodes(cachedMediaObject)
                self.presenter.presentMedia(media: mediaModel)
            }
        }
    }
    
    func getCategories()  {
        let categories = realm.objects(Categories.self)
        if categories.isEmpty {
            presenter.displayLoadingIndicator()
            worker.callCategories(completionHandler: {[weak self] (categories, error) in
                DispatchQueue.main.async {
                    if let cacheableObject = categories {
                        if RealmManager.sharedInstance.saveObject(object: cacheableObject) {
                            let categoryModel = MindValleySectionModel.MVCategories(cacheableObject)
                            self?.presenter.presentCategories(categories: categoryModel)
                        } else {
                            self?.presenter.failToSaveInDB()
                        }
                    } else {
                        self?.presenter.errorWhileFetching()
                    }
                }
            })
        } else {
            if let cachedObject  = categories.first {
                let categoryModel = MindValleySectionModel.MVCategories(cachedObject)
                self.presenter.presentCategories(categories: categoryModel)
            }
        }
    }
    
    func getChannels()  {
        let channels = realm.objects(Channels.self)
        if channels.isEmpty {
            presenter.displayLoadingIndicator()
            worker.callChannels(completionHandler: {[weak self] (channels, error) in
                DispatchQueue.main.async {
                    if let cacheableObject = channels {
                        if RealmManager.sharedInstance.saveObject(object: cacheableObject) {
                            if let channelList = self?.getSubChannel(channels: cacheableObject){
                                self?.presenter.presentChannel(channels: channelList)
                            }
                        } else {
                            self?.presenter.failToSaveInDB()
                        }
                    } else {
                        self?.presenter.errorWhileFetching()
                    }
                }
            })
        } else {
            if let cachedObject  = channels.first {
                let channelList = getSubChannel(channels: cachedObject)
                self.presenter.presentChannel(channels: channelList)
            }
        }
    }
    
    func getSubChannel(channels: Channels) -> [MindValleySectionModel] {
        var channelModal = [MindValleySectionModel]()
        if let channels = channels.data?.channels{
            for newChannel in channels {
                print(newChannel)
                let newChannelSection = MindValleySectionModel.NewChannel(newChannel)
                channelModal.append(newChannelSection)
            }
        }
        return channelModal
    }
}



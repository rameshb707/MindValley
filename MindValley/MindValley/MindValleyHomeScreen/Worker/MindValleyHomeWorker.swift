//
//  MindValleyHomeWorker.swift
//  MindValley
//
//  Created by Ramesh B on 27/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import Foundation


/// As the name suggest it has to do work by calling the API from network manager and send the call back to interactor
class MindValleyHomeWorker {
    
    /// Intitializes when it neccessary
    private lazy var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    func callMedia(completionHandler: @escaping (Media?, Error?) -> ()) {
        let request = Request(endPoint: Constants.media)
        networkManager.send(modelType: Media.self, request, { (media, response, error) in
            if let mediaObject = media as? Media {
                completionHandler(mediaObject, nil)
            } else {
                completionHandler(nil, error)
            }
        })
    }
    
    func callChannels(completionHandler: @escaping (Channels?, Error?) -> ()) {
n        networkManager.send(modelType: Channels.self, request, { (media, response, error) in
            if let channelsObject = media as? Channels {
                completionHandler(channelsObject, nil)
            } else {
                completionHandler(nil, error)
            }
        })
    }
    
    func callCategories(completionHandler: @escaping (Categories?, Error?) -> ()) {
        let request = Request(endPoint: Constants.categories)
        networkManager.send(modelType: Categories.self, request, { (media, response, error) in
            if let categoriesObject = media as? Categories {
                completionHandler(categoriesObject, nil)
            } else {
                completionHandler(nil, error)
            }
        })
    }
}

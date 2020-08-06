//
//  MindValleyTests.swift
//  MindValleyTests
//
//  Created by Ramesh B on 24/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import XCTest
import RealmSwift
@testable import MindValley

class MindValleyTests: XCTestCase {
    
    var mindValleyHomeViewController: MindValleyHomeViewController!
    var worker: MindValleyHomeWorker!
    override func setUp() {
        super.setUp()
        setUpViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        mindValleyHomeViewController = nil
    }
    
    private func setUpViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mindValleyHomeViewController = storyboard.instantiateViewController(withIdentifier: "MindValleyHomeViewController") as? MindValleyHomeViewController
        mindValleyHomeViewController.viewDidLoad()
        let _ = mindValleyHomeViewController?.view
        mindValleyHomeViewController?.viewWillAppear(false)
        
        worker = MindValleyHomeWorker()
    }
    
    func testNumberOfRows() {
        XCTAssertNotNil(mindValleyHomeViewController.mindValleyHomeTableView)
        XCTAssertNotNil(mindValleyHomeViewController.sections)
        XCTAssertNotNil(mindValleyHomeViewController.mindValleyHomeTableView.numberOfRows(inSection: 0) > 0)
    }
    
    func testNewEpisodesSection() {
        let mindValleyMediaException = expectation(description: "Expected to media object")
        
        mindValleyHomeViewController.sections.removeAll()
        mindValleyHomeViewController.presenter.interactor.worker.callMedia {[weak self] (media, error) in
            DispatchQueue.main.async {
                XCTAssertNotNil(media)
                let mediaModel = MindValleySectionModel.MVNewEpisiodes(media!)
                if let mediaSection = MindValleySection.buildSections(entity: mediaModel) {
                    self?.mindValleyHomeViewController?.sections.append((1, mediaSection))
                }
                XCTAssertNotNil(self?.mindValleyHomeViewController?.mindValleyHomeTableView.numberOfRows(inSection: 0) == 1)
                self?.checlMediaItems(media: media)
            }
            mindValleyMediaException.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func checlMediaItems(media: Media?) {
        let mediaSectionCell = self.mindValleyHomeViewController?.mindValleyHomeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MindValleySectionCell
        let episodeCount =  mediaSectionCell?.categoriesCollectionView.numberOfItems(inSection: 0)
        XCTAssert(episodeCount == media?.data?.media.count)
    }
    
    func testCategoriesSection() {
        let mindValleyCategoryException = expectation(description: "Expected to categorie object")
        
        mindValleyHomeViewController.sections.removeAll()
        mindValleyHomeViewController.presenter.interactor.worker.callCategories {[weak self] (categorie, error) in
            DispatchQueue.main.async {
                XCTAssertNotNil(categorie)
                let categorieModel = MindValleySectionModel.MVCategories(categorie!)
                if let categorieSection = MindValleySection.buildSections(entity: categorieModel) {
                    self?.mindValleyHomeViewController?.sections.append((3, categorieSection))
                }
                XCTAssertNotNil(self?.mindValleyHomeViewController?.mindValleyHomeTableView.numberOfRows(inSection: 0) == 1)
                self?.checkCategorieItems(categorie: categorie)
            }
            mindValleyCategoryException.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func checkCategorieItems(categorie: Categories?) {
        let mediaSectionCell = self.mindValleyHomeViewController?.mindValleyHomeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MindValleySectionCell
        let categorieCount =  mediaSectionCell?.categoriesCollectionView.numberOfItems(inSection: 0)
        XCTAssert(categorieCount == categorie?.categoryList?.categoriess.count)
    }
    
    func testChannelsSection() {
        let mindValleyChannelException = expectation(description: "Expected to channels object")
        
        mindValleyHomeViewController.presenter.interactor.worker.callChannels {[weak self] (channels, error) in
            DispatchQueue.main.async {
                XCTAssertNotNil(channels)
                for newchannel in (channels?.data?.channels)! {
                    self?.checkChannelItems(channel: newchannel)
                }
            }
            mindValleyChannelException.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func checkChannelItems(channel: Channel?) {
        mindValleyHomeViewController.sections.removeAll()
        let channelModel = MindValleySectionModel.NewChannel(channel!)
        if let channelSection = MindValleySection.buildSections(entity: channelModel) {
            self.mindValleyHomeViewController?.sections.append((2, channelSection))
        }
        XCTAssertNotNil(self.mindValleyHomeViewController?.mindValleyHomeTableView.numberOfRows(inSection: 0) == 1)
        let channelSectionCell = self.mindValleyHomeViewController?.mindValleyHomeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MindValleySectionCell
        let categorieCount =  channelSectionCell?.categoriesCollectionView.numberOfItems(inSection: 0)
        if ((channel?.series.isEmpty)!) {
            XCTAssert(categorieCount == channel?.latestMedia.count)
        } else {
            XCTAssert(categorieCount == channel?.series.count)
        }
    }
    
    func testRealmSavedObjects() {
        let realm = RealmManager.sharedInstance.realmRef()
        mindValleyHomeViewController.presenter.interactor.getMindValleyData()

        let media = realm.objects(Media.self)
        XCTAssert(media.count > 0)
        
        mindValleyHomeViewController.presenter.interactor.getChannels()

        let channel = realm.objects(Channels.self)
        XCTAssert(channel.count > 0)
    }
}



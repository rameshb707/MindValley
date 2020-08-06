//
//  Configurator.swift
//  MindValley
//
//  Created by Ramesh B on 27/6/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit

/// It helps to configure the required refrences which is neccessary
final class MindValleyHomeConfigurator {

  // MARK: - Object lifecycle
  static let sharedInstance = MindValleyHomeConfigurator()

  // MARK: - Configuration
  func configure(viewController: MindValleyHomeViewController) {

    let presenter = MindValleyHomePresenter()
    viewController.presenter = presenter
    presenter.viewController = viewController

    let interactor = MindValleyHomeInteractor()
    interactor.presenter = presenter
    presenter.interactor = interactor

  }
}



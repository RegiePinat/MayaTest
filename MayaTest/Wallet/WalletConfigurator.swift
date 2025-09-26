//
//  WalletConfigurator.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

enum WalletConfigurator {
    static func configure(_ viewController: WalletViewController) {
        let interactor = WalletInteractor()
        let presenter = WalletPresenter()
        let router = WalletRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
    }
}

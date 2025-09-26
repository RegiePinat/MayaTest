//
//  SendMoneyConfigurator.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

enum SendMoneyConfigurator {
    static func configure(_ viewController: SendMoneyViewController) {
        
        let worker = SendMoneyWorker()
        
        let interactor = SendMoneyInteractor(worker: worker)
        let presenter = SendMoneyPresenter()
        let router = SendMoneyRouter()
        
        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
    }
}

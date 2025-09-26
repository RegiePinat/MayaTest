//
//  TransactionHistoryConfigurator.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

enum TransactionHistoryConfigurator {
    static func configure(_ viewController: TransactionHistoryViewController) {
        
        let worker = TransactionHistoryWorker()
        
        let interactor = TransactionHistoryInteractor(worker: worker)
        let presenter = TransactionHistoryPresenter()
        let router = TransactionHistoryRouter()
        
        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
    }
}

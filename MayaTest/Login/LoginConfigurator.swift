//
//  LoginConfigurator.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import Foundation

enum LoginConfigurator {
    static func configure(_ viewController: LoginViewController) {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter

        presenter.viewController = viewController

        router.viewController = viewController
    }
}

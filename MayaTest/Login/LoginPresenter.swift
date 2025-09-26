//
//  LoginPresenter.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import Foundation

protocol LoginPresentationLogic {
    func presentAuthenticationError(response: Login.Authenticate.Response)
    func presentWalletScreen()
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentAuthenticationError(response: Login.Authenticate.Response) {
        let message = response.errorMessage ?? "Unknown error"
        let viewModel = Login.Authenticate.ViewModel(message: message)
        viewController?.displayErrorLoginResult(viewModel: viewModel)
    }
    
    func presentWalletScreen() {
        viewController?.displayWalletScreen()
    }
}

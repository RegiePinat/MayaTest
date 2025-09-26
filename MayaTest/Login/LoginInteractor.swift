//
//  LoginInteractor.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import Foundation

protocol LoginBusinessLogic {
    func authenticate(request: Login.Authenticate.Request)
}

class LoginInteractor: LoginBusinessLogic {
    var presenter: LoginPresentationLogic?
    var loggedInUser: String?

    func authenticate(request: Login.Authenticate.Request) {
        if request.username == "admin" && request.password == "1234" {
            loggedInUser = request.username
            presenter?.presentWalletScreen()
        } else {
            let response = Login.Authenticate.Response(success: false, errorMessage: "Invalid credentials")
            presenter?.presentAuthenticationError(response: response)
        }
    }
}

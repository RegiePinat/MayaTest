//
//  TransactionHistoryRouter.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import UIKit

protocol TransactionHistoryRoutingLogic {
    func signOut()
}

class TransactionHistoryRouter: TransactionHistoryRoutingLogic {
  
    weak var viewController: TransactionHistoryViewController?

    func signOut() {
        let loginVC = LoginViewController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let window = sceneDelegate.window
            window?.rootViewController = loginVC
            window?.makeKeyAndVisible()
        }
    }
    
}

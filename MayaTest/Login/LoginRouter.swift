//
//  LoginRouter.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import UIKit

protocol LoginRoutingLogic {
    func routeToWallet()
}


class LoginRouter: LoginRoutingLogic {
    weak var viewController: LoginViewController?
    
    func routeToWallet() {
        let walletVC = WalletViewController()
        let navController = UINavigationController(rootViewController: walletVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}

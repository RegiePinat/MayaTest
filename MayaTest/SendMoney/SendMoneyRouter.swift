//
//  SendMoneyRouter.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import UIKit

protocol SendMoneyRoutingLogic {
    func signOut()
}

class SendMoneyRouter: SendMoneyRoutingLogic {
  
    weak var viewController: SendMoneyViewController?

    func signOut() {
        let loginVC = LoginViewController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let window = sceneDelegate.window
            window?.rootViewController = loginVC
            window?.makeKeyAndVisible()
        }
    }
    
}

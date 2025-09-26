//
//  WalletRouter.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import UIKit

protocol WalletRoutingLogic {
    func routeToSendMoney()
    func routeToTransactionHistory()
    func signOut()
}

class WalletRouter: WalletRoutingLogic {
  
    weak var viewController: WalletViewController?
    
    func routeToSendMoney() {
        let sendMoneyVC = SendMoneyViewController()
        guard let navController = viewController?.navigationController else { return }
        navController.pushViewController(sendMoneyVC, animated: true)
    }
    
    func routeToTransactionHistory() {
        let transactionHistoryVC = TransactionHistoryViewController()
        guard let navController = viewController?.navigationController else { return }
        navController.pushViewController(transactionHistoryVC, animated: true)
    }
    
    func signOut() {
        let loginVC = LoginViewController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let window = sceneDelegate.window
            window?.rootViewController = loginVC
            window?.makeKeyAndVisible()
        }
    }
}

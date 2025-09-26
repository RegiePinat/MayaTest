//
//  WalletInteractor.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol WalletBusinessLogic {
    func showWalletValue()
    func hideWalletValue()
    func requestWalletValue()
}

class WalletInteractor: WalletBusinessLogic {
    var presenter: WalletPresentationLogic?
    var walletValue:Double
    var isWalletValueHidden: Bool
    
    init() {
        self.walletValue = 0
        self.isWalletValueHidden = false
    }

    func showWalletValue() {
        self.isWalletValueHidden = false
        presenter?.presentWalletAmountAsShown(viewModel: Wallet.DisplayWallet.ViewModel(balance: self.walletValue, isHidden: self.isWalletValueHidden))
    }
    
    func hideWalletValue() {
        self.isWalletValueHidden = true
        presenter?.presentWalletAmountAsHidden(viewModel: Wallet.DisplayWallet.ViewModel(balance: self.walletValue, isHidden: self.isWalletValueHidden))
    }
    
    func requestWalletValue() {
        let randomDouble = Double.random(in: 1...50000)
        
        self.walletValue = randomDouble
        presenter?.presentFetchedWalletAmount(response: Wallet.FetchWallet.Response(success: true, errorMessage: nil, balance: self.walletValue, isHidden: self.isWalletValueHidden))
    }
}

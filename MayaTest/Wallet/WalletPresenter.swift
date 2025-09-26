//
//  WalletPresenter.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol WalletPresentationLogic {
    func presentFetchedWalletAmount(response: Wallet.FetchWallet.Response)
    func presentWalletAmountAsHidden(viewModel: Wallet.DisplayWallet.ViewModel)
    func presentWalletAmountAsShown(viewModel: Wallet.DisplayWallet.ViewModel)
}


class WalletPresenter: WalletPresentationLogic {
    
    weak var viewController: WalletDisplayLogic?
    

    func presentFetchedWalletAmount(response: Wallet.FetchWallet.Response) {
        let response = response
        viewController?.displayWalletBalance(viewModel: Wallet.FetchWallet.ViewModel(balance: response.balance, isHidden: response.isHidden, errorMessage: ""))
    }
    
    func presentWalletAmountAsShown(viewModel: Wallet.DisplayWallet.ViewModel) {
        viewController?.showWalletBalance(viewModel: viewModel)
    }
    
    func presentWalletAmountAsHidden(viewModel: Wallet.DisplayWallet.ViewModel) {
        viewController?.hideWalletBalance(viewModel: viewModel)
    }
    
}

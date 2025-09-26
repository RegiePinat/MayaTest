//
//  SendMoneyPresenter.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol SendMoneyPresentationLogic {
    func presentSendMoneyResult(response: SendMoney.SendAPICall.Response)
}


class SendMoneyPresenter: SendMoneyPresentationLogic {

    
    weak var viewController: SendMoneyDisplayLogic?
    
    func presentSendMoneyResult(response: SendMoney.SendAPICall.Response) {
        let balance  = String(response.balance)
        viewController?.displayResult(viewModel: SendMoney.SendAPICall.ViewModel(message: response.message, balance: balance, success: response.success))
    }
}

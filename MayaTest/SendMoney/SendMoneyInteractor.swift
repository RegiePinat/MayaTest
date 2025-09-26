//
//  SendMoneyInteractor.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol SendMoneyBusinessLogic {
    func sendMoney(amount: Double)
}

class SendMoneyInteractor: SendMoneyBusinessLogic {
    var presenter: SendMoneyPresentationLogic?
    var worker: SendMoneyWorkerProtocol
    
    init(worker: SendMoneyWorkerProtocol) {
        self.worker = worker
    }
    
    func sendMoney(amount: Double) {
        self.worker.sendMoney(amount: amount) { [weak self] result in
            
            switch result {
            case .success(let response):
                self?.presenter?.presentSendMoneyResult(response: SendMoney.SendAPICall.Response(success: true, message: "You sent ₱\(amount)!", balance: response.amount))
                
            case .failure(let error):
                self?.presenter?.presentSendMoneyResult(response: SendMoney.SendAPICall.Response(success: false, message: error.localizedDescription, balance: 0))
            }
        }
        
    }
}

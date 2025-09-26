//
//  TransactionHistoryInteractor.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol TransactionHistoryBusinessLogic {
    func fetchTransactionHistory()
}

class TransactionHistoryInteractor: TransactionHistoryBusinessLogic {
    var presenter: TransactionHistoryPresentationLogic?
    var worker: TransactionHistoryWorkerProtocol
    
    init(worker: TransactionHistoryWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchTransactionHistory() {
        worker.fetchTransactionHistory { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentTransactions(response: response)
            case .failure(let error):
                self?.presenter?.presentErrorFetchHistoryResult(errorMessage: error.localizedDescription)
                
            }
        }
    }
}

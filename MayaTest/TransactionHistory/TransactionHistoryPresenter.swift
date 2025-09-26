//
//  TransactionHistoryPresenter.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol TransactionHistoryPresentationLogic {
    func presentTransactions(response: TransactionHistory.FetchHistory.Response)
    func presentErrorFetchHistoryResult(errorMessage: String)
}


class TransactionHistoryPresenter: TransactionHistoryPresentationLogic {

    
    weak var viewController: TransactionHistoryDisplayLogic?
    
    func presentTransactions(response: TransactionHistory.FetchHistory.Response) {
        let transactions = response.transactionHistory
        var transactionsViewModels: [TransactionHistory.FetchHistory.TransactionViewModel] = []
        
        for transaction in transactions {
            let viewModel = TransactionHistory.FetchHistory.TransactionViewModel(name: transaction.name, amount: transaction.amount, isSuccess: transaction.isSuccess)
            transactionsViewModels.append(viewModel)
        }
        viewController?.displayFetchedTransactionHistory(viewModel: TransactionHistory.FetchHistory.ViewModel(transactions: transactionsViewModels, message: ""))
    }
    
    func presentErrorFetchHistoryResult(errorMessage: String) {
        viewController?.displayErrorFetchHistoryResult(viewModel: TransactionHistory.FetchHistory.ViewModel(transactions: [], message: errorMessage))
    }
}

//
//  Transaction.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import Foundation


enum TransactionHistory {
    enum FetchHistory {
        
        
        struct Response: Codable {
            let transactionHistory: [TransactionHistory.FetchHistory.Transaction]
        }
        
        struct ViewModel {
            let transactions: [TransactionHistory.FetchHistory.TransactionViewModel]
            let message: String
        }
        
        
        struct Transaction: Codable {
            let name: String
            let amount: Double
            let isSuccess: Bool
        }
        
        struct TransactionViewModel {
            let name: String
            let amount: String
            let isSuccess: Bool
            init(name: String, amount: Double, isSuccess: Bool) {
                self.name = name
                self.isSuccess = isSuccess
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                formatter.locale = Locale.current
                self.amount = formatter.string(from: NSNumber(value: amount)) ?? "₱0"
            }
        }
    }
}



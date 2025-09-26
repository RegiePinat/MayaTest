//
//  WalletModels.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

enum Wallet {

    enum FetchWallet {

        struct Response {
            let success: Bool
            let errorMessage: String?
            let balance: Double
            let isHidden: Bool
        }

        struct ViewModel {
            let balanceText: String
            let isHidden: Bool
            let errorMessage: String
            
            init(balance: Double, isHidden: Bool, errorMessage: String) {
                
               
                self.isHidden = isHidden
                self.errorMessage = errorMessage
                
                if (self.isHidden) {
                    self.balanceText = "••••••••"
                } else {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    formatter.locale = Locale.current
                    self.balanceText = formatter.string(from: NSNumber(value: balance)) ?? "₱0"
                }
            }
        }
    }
    
    enum DisplayWallet {
        
        struct ViewModel {
            let balanceText: String
            let isHidden: Bool
            
            init(balance: Double, isHidden: Bool) {
                self.isHidden = isHidden
                
                if (self.isHidden) {
                    self.balanceText = "••••••••"
                } else {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    formatter.locale = Locale.current
                    self.balanceText = formatter.string(from: NSNumber(value: balance)) ?? "₱0"
                }
            }
        }
    }
}

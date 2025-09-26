//
//  SendMoneyModels.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation


struct SendMoneyRequest: Codable {
    let amount: Double
}

struct SendMoneyResponse: Codable {
    let amount: Double
}


enum SendMoney {
    
    enum SendAPICall {
        
        struct Response {
            let success: Bool
            let message: String
            let balance: Double
        }
        
        struct ViewModel {
            let message: String
            let balance: String
            let success: Bool
        }
    }
    
}

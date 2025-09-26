//
//  LoginModels.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import Foundation

enum Login {
    enum Authenticate {
        struct Request {
            let username: String
            let password: String
        }
        struct Response {
            let success: Bool
            let errorMessage: String?
        }
        struct ViewModel {
            let message: String
        }
    }
}

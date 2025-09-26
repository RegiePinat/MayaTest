//
//  TransactionHistoryWorker.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol TransactionHistoryWorkerProtocol {
    func fetchTransactionHistory(completion: @escaping (Result<TransactionHistory.FetchHistory.Response, Error>) -> Void)
}

class TransactionHistoryWorker: TransactionHistoryWorkerProtocol {
    
    func fetchTransactionHistory(completion: @escaping (Result<TransactionHistory.FetchHistory.Response, Error>) -> Void) {
        
        guard let url = URL(string: "https://my-json-server.typicode.com/RegiePinat/demoTestApi/transactionHistory") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 0)))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data else {
                    completion(.failure(NSError(domain: "NoData", code: 0)))
                    return
                }
                do {
                    let transactions = try JSONDecoder().decode([TransactionHistory.FetchHistory.Transaction].self, from: data)
                    let apiResponse = TransactionHistory.FetchHistory.Response(transactionHistory: transactions)
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(error))
                }
            case 400...499:
                completion(.failure(NSError(domain: "ClientError", code: httpResponse.statusCode)))
            case 500...599:
                completion(.failure(NSError(domain: "ServerError", code: httpResponse.statusCode)))
            default:
                completion(.failure(NSError(domain: "UnknownError", code: httpResponse.statusCode)))
            }
        }.resume()
        
    }

}

//
//  SendMoneyWorker.swift
//  MayaTest
//
//  Created by Guest  User on 9/26/25.
//

import Foundation

protocol SendMoneyWorkerProtocol {
    func sendMoney(amount: Double, completion: @escaping (Result<SendMoneyResponse, Error>) -> Void)
}

class SendMoneyWorker: SendMoneyWorkerProtocol {
    
    func sendMoney(amount: Double, completion: @escaping (Result<SendMoneyResponse, Error>) -> Void) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(amount)
        } catch {
            completion(.failure(error))
            return
        }
        
        let session = URLSession.shared

        session.dataTask(with: urlRequest) { data, response, error in
            
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
                    let apiResponse = try JSONDecoder().decode(SendMoneyResponse.self, from: data)
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

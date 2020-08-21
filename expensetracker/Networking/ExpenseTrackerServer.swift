//
//  ExpenseTrackerServer.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

class ExpenseAppServer {
    static let shared = ExpenseAppServer()

    func signUp(name: String, email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let parameters = [
            "name": name,
            "email": email,
            "password": password
        ]
        makeAPICall(route: .signup, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (data, response, error, result) in
            
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let parameters = [
            "email": email,
            "password": password
        ]
        makeAPICall(route: .login, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (data, response, error, result) in
            
        }
    }
    
    func createExpense(category: String, purpose: String, amount: Double) {
        let parameters: [String: Any] = [
            "category": category,
            "purpose": purpose,
            "amount": amount
        ]
        makeAPICall(route: .createExpense, method: .post, paramaters: parameters, type: ExpenseCreateResponse.self) { (data, response, error, result) in
            
        }
    }
    
    func updateExpense(expenseId: String, amount: Double) {
    }
    
    func deleteExpense(expenseId: String) {
    }
    
    func readExpenses() {
    }
}

extension ExpenseAppServer {
    private func makeAPICall<T: Codable>(route: Route, method: Method, paramaters: [String: Any]? = nil, type: T.Type, headerParameters: [String: String]? = nil, requiresToken: Bool = false, _ completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?, _ result: T? ) -> Void ) {
        
        guard let request = createRequest(route: route, method: method, parameters:paramaters, headerParameters: headerParameters) else {
            completion(nil, nil, ExpenseAppErrors.unknownError, nil)
            return
        }
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error, self?.makeResponseFrom(data: data, type: T.self))
            }
        }.resume()
    }
    
    private func createRequest(route: Route, method: Method, parameters: [String: Any]? = nil, headerParameters: [String: String]? = nil) -> URLRequest? {
        guard let url = URL(string: route.description) else { return nil }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        var headers = [
            "Content-Type": "application/json"
        ]
        if let headerParam = headerParameters {
            for (key, value) in headerParam {
                headers[key] = value
            }
        }
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        if let parameters = parameters, method == .post || method == .delete || method == .put {
            do {
                let json: Data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = json
            } catch {
                return nil
            }
        }
        return request
    }
    
    private func makeResponseFrom<T: Decodable>(data: Data?, type: T.Type) -> T? {
        guard let data = data else { return nil }
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(T.self, from: data)
    }
}

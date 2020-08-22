//
//  AuthServer.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension ExpenseAppServer {
    func signUp(name: String, email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let parameters = [
            "name": name,
            "email": email,
            "password": password
        ]
        makeAPICall(route: .signup, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (data, response, error, result) in
            if let success = result?.success, success {
                self.saveSignedInUser(user: result?.user)
                DispatchQueue.main.async {
                    completion(result?.user, nil)
                }
            } else {
                completion(nil, ExpenseAppErrors.loginFailed(result?.errors?.first ?? result?.message))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let parameters = [
            "email": email,
            "password": password
        ]
        makeAPICall(route: .login, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (data, response, error, result) in
            if let success = result?.success, success {
                self.saveSignedInUser(user: result?.user)
                DispatchQueue.main.async {
                    completion(result?.user, nil)
                }
            } else {
                completion(nil, ExpenseAppErrors.loginFailed(result?.errors?.first ?? result?.message))
            }
        }
    }
    
    private func saveSignedInUser(user: User?) {
        if let user = user {
            UserDefaults.standard.signedInUser = user
        }
    }
}

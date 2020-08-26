//
//  AuthServer.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension ExpenseAppServer {
    func signUp(name: String, email: String, password: String, completion: @escaping UserAuthenticationCompletionHandler) {
        let parameters = [
            "name": name,
            "email": email,
            "password": password
        ]
        makeAPICall(route: .signup, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (error, data, result) in
            if let success = result?.success, success {
                self.saveSignedInUser(user: result?.user, token: result?.token)
                DispatchQueue.main.async {
                    completion(result?.user, nil)
                }
            } else {
                completion(nil, error ?? ExpenseAppErrors.loginFailed(result?.errors?.first ?? result?.message))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping UserAuthenticationCompletionHandler) {
        let parameters = [
            "email": email,
            "password": password
        ]
        makeAPICall(route: .login, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (error, data, result) in
            if let success = result?.success, success {
                self.saveSignedInUser(user: result?.user, token: result?.token)
                DispatchQueue.main.async {
                    completion(result?.user, nil)
                }
            } else {
                completion(nil, error ?? ExpenseAppErrors.loginFailed(result?.errors?.first ?? result?.message))
            }
        }
    }
    
    func recoverAccount(email: String, completion: @escaping AccountRecoveryCompletionHandler) {
        let parameters = [
            "email": email
        ]
        makeAPICall(route: .recoverAccount, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (error, data, result) in
            if let success = result?.success, success {
                self.saveSignedInUser(user: result?.user, token: result?.token)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                completion(error ?? ExpenseAppErrors.accountRecoveryFailed(result?.errors?.first ?? result?.message))
            }
        }
    }
    
    func resetPassword(newPassword: String, completion: @escaping AccountRecoveryCompletionHandler) {
        let parameters = [
            "newPassword": newPassword
        ]
        makeAPICall(route: .resetPassword, method: .post, paramaters: parameters, type: UserAuthResponse.self) { (error, data, result) in
            if let success = result?.success, success {
                self.saveSignedInUser(user: result?.user, token: result?.token)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                completion(error ?? ExpenseAppErrors.passwordResetFailed(result?.errors?.first ?? result?.message))
            }
        }
    }
    
    private func saveSignedInUser(user: User?, token: String?) {
        UserDefaults.standard.signedInUser = user
        UserDefaults.standard.authToken = token
    }
}

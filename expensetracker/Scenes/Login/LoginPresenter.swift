//
//  LoginPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter: NSObject {
    weak var view: LoginInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared

    init(view: LoginInput) {
        self.view = view
        self.parentView = view.view
    }
    
    private func toggleButton(enable: Bool) {
        self.view?.continueButton.isEnabled = enable
        enable ? self.view?.activityIndicator.stopAnimating() : self.view?.activityIndicator.startAnimating()
    }
}

extension LoginPresenter: LoginOutput {
    func recoverAccount() {
        let recoverAccountVC = ForgottenPasswordViewController.instantiate(fromAppStoryboard: .Main)
        (self.view as? UIViewController)?.present(recoverAccountVC, animated: true)
    }
    
    func goToSignup() {
        let loginVC = SignupViewController.instantiate(fromAppStoryboard: .Main)
        (self.view as? UIViewController)?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func signIn() {
        validateAndSignIn()
    }
    
    private func validateAndSignIn() {
        guard let view = self.view else { return }
        if let email = view.emailTextField.text, !email.isEmpty,
            let password = view.passwordTextField.text, !password.isEmpty {
            if !email.isValidEmail() {
                Utility.showNotification(message: String.ErrorMessages.invalidEmail, view: self.parentView, isError: true)
                return
            }
            
            if !password.isValidPasswordText() {
                Utility.showNotification(message: String.ErrorMessages.passwordError, view: self.parentView, isError: true)
                return
            }
            
            toggleButton(enable: false)
            server.signIn(email: email, password: password) { (user, error) in
                self.toggleButton(enable: true)
                if let error = error {
                    Utility.showNotification(message: error.localizedDescription, view: self.parentView, isError: true)
                } else {
                    Utility.goHome()
                }
            }
        } else {
            Utility.showNotification(message: String.ErrorMessages.missingFields, view: self.parentView, isError: true)
        }
    }
}

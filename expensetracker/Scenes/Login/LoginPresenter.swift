//
//  LoginPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol LoginInput: class {
    var view: UIView! { get set }
    var emailTextField: UITextField! { get set }
    var passwordTextField: UITextField! { get set }
    var continueButton: UIButton! { get set }
    var activityIndicator: UIActivityIndicatorView! { get set }
}

protocol LoginOutput: class {
    func signIn()
    func goToSignup()
}

class LoginPresenter: NSObject {
    weak var view: LoginInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared

    init(view: LoginInput) {
        self.view = view
        self.parentView = view.view
    }
    
    private func validateAndSignIn() {
        guard let view = self.view else { return }
        if let email = view.emailTextField.text, !email.isEmpty,
            let password = view.passwordTextField.text, !password.isEmpty {
            if !email.isValidEmail() {
                Utility.showError(message: String.ErrorMessages.invalidEmail, view: self.parentView)
                return
            }
            
            if !password.isValidPasswordText() {
                Utility.showError(message: String.ErrorMessages.passwordError, view: self.parentView)
                return
            }
            
            toggleButton(enable: false)
            server.signIn(email: email, password: password) { (user, error) in
                self.toggleButton(enable: true)
                if let error = error {
                    Utility.showError(message: error.localizedDescription, view: self.parentView)
                } else {
                    Utility.goHome()
                }
            }
        } else {
            Utility.showError(message: String.ErrorMessages.missingFields, view: self.parentView)
        }
    }
    
    private func toggleButton(enable: Bool) {
        self.view?.continueButton.isEnabled = enable
        enable ? self.view?.activityIndicator.stopAnimating() : self.view?.activityIndicator.startAnimating()
    }
}

extension LoginPresenter: LoginOutput {
    func goToSignup() {
        let loginVC = SignupViewController.instantiate(fromAppStoryboard: .Main)
        (self.view as? UIViewController)?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func signIn() {
        validateAndSignIn()
    }
}

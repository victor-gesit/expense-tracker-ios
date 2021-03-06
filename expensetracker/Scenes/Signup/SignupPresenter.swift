//
//  SignupPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class SignupPresenter: NSObject {
    weak var view: SignupInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared
    
    init(view: SignupInput) {
        self.view = view
        self.parentView = view.view
    }

    private func validateAndSignUp() {
        guard let view = self.view else { return }
        if let email = view.emailTextField.text, !email.isEmpty,
            let name = view.nameTextField.text, !name.isEmpty,
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
            server.signUp(name: name, email: email, password: password) { (user, error) in
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
    
    private func toggleButton(enable: Bool) {
        self.view?.continueButton.isEnabled = enable
        enable ? self.view?.activityIndicator.stopAnimating() : self.view?.activityIndicator.startAnimating()
    }
}

extension SignupPresenter: SignupOutput {
    func goToLogin() {
        let loginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
        (self.view as? UIViewController)?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func signUp() {
        validateAndSignUp()
    }
}

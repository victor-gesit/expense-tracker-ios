//
//  SignupPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol SignupInput: class {
    var view: UIView! { get set }
    var nameTextField: UITextField! { get set }
    var emailTextField: UITextField! { get set }
    var passwordTextField: UITextField! { get set }
    var continueButton: UIButton! { get set }
    var activityIndicator: UIActivityIndicatorView! { get set }
}

protocol SignupOutput: class {
    func signUp()
    func goToLogin()
}

class SignupPresenter: NSObject {
    weak var view: SignupInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared
    
    init(view: SignupInput) {
        self.view = view
        self.parentView = view.view
    }

    private func validateAndSignUp() {
        Utility.goHome()
        return
        guard let view = self.view else { return }
        if let email = view.emailTextField.text, !email.isEmpty,
            let name = view.nameTextField.text, !name.isEmpty,
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
            server.signUp(name: name, email: email, password: password) { (user, error) in
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

extension SignupPresenter: SignupOutput {
    func goToLogin() {
        let loginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
        (self.view as? UIViewController)?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func signUp() {
        validateAndSignUp()
    }
}

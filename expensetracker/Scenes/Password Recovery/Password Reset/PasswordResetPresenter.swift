//
//  SignupPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class PasswordResetPresenter: NSObject {
    weak var view: PasswordResetInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared
    
    init(view: PasswordResetInput) {
        self.view = view
        self.parentView = view.view
    }

    private func validateAndResetPassword() {
        guard let view = self.view else { return }
        if let password = view.passwordTextField.text, let reenteredPassword = view.reenterPasswordTextField.text,
            !reenteredPassword.isEmpty,
            !password.isEmpty {
            
            if !password.isValidPasswordText() {
                Utility.showNotification(message: String.ErrorMessages.passwordError, view: self.parentView, isError: true)
                return
            }
            
            if password != reenteredPassword {
                Utility.showNotification(message: String.ErrorMessages.passwordMismatchError, view: self.parentView, isError: true)
                return
            }

            toggleButton(enable: false)
            server.resetPassword(newPassword: password) { (error) in
                self.toggleButton(enable: true)
                if let error = error {
                    Utility.showNotification(message: error.localizedDescription, view: self.parentView, isError: true)
                } else {
                    Utility.showNotification(message: String.SuccessMessages.passwordResetSuccessfully, view: self.parentView)
                    Utility.goToLogin()
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

extension PasswordResetPresenter: PasswordResetOutput {
    func resetPassword() {
        validateAndResetPassword()
    }
    
    func goToLogin() {
        let loginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
        (self.view as? UIViewController)?.navigationController?.pushViewController(loginVC, animated: true)
    }
}

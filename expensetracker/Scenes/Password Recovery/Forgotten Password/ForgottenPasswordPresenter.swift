//
//  SignupPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class ForgottenPasswordPresenter: NSObject {
    weak var view: ForgottenPasswordInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared
    
    init(view: ForgottenPasswordInput) {
        self.view = view
        self.parentView = view.view
    }

    private func validateAndRecoverAccount() {
        guard let view = self.view else { return }
        if let email = view.emailTextField.text, !email.isEmpty {
            if !email.isValidEmail() {
                Utility.showNotification(message: String.ErrorMessages.invalidEmail, view: self.parentView, isError: true)
                return
            }
            
            toggleButton(enable: false)
            server.recoverAccount(email: email) { (error) in
                self.toggleButton(enable: true)
                if let error = error {
                    Utility.showNotification(message: error.localizedDescription, view: self.parentView, isError: true)
                } else {
                    Utility.showNotification(message: String.SuccessMessages.recoveryMailSent, view: self.parentView)
                    (self.view as? UIViewController)?.dismiss(animated: true)
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

extension ForgottenPasswordPresenter: ForgottenPasswordOutput {
    func goToLogin() {
        Utility.goToLogin()
    }
    
    func recoverAccount() {
        validateAndRecoverAccount()
    }
}



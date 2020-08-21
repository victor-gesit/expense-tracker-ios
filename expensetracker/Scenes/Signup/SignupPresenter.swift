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
}

protocol SignupOutput: class {
    func signUp()
}

class SignupPresenter: SignupOutput {
    weak var view: SignupInput?
    var parentView: UIView
    let server = ExpenseAppServer.shared
    
    init(view: SignupInput) {
        self.view = view
        self.parentView = view.view
    }
    
    func signUp() {
        Utility.showError(message: String.ErrorMessages.invalidEmail, view: self.parentView)
    }
}

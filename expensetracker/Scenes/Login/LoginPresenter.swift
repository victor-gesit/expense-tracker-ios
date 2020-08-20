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
    var emailTextField: UITextField! { get set }
    var passwordTextField: UITextField! { get set }
}

protocol LoginOutput: class {
    func signIn()
}

class LoginPresenter: LoginOutput {
    weak var view: LoginInput?
    
    init(view: LoginInput) {
        self.view = view
    }
    
    func signIn() {
    }
}

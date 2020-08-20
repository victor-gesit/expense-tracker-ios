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
    var nameTextField: UITextField! { get set }
    var emailTextField: UITextField! { get set }
    var passwordTextField: UITextField! { get set }
}

protocol SignupOutput: class {
    func signUp()
}

class SignupPresenter: SignupOutput {
    weak var view: SignupInput?
    
    init(view: SignupInput) {
        self.view = view
    }
    
    func signUp() {
    }
}

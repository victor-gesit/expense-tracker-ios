//
//  PresenterProtocols.swift
//  expensetracker
//
//  Created by Victor Idongesit on 24/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol PasswordResetInput: class {
    var view: UIView! { get set }
    var passwordTextField: UITextField! { get set }
    var reenterPasswordTextField: UITextField! { get set }
    var continueButton: UIButton! { get set }
    var activityIndicator: UIActivityIndicatorView! { get set }
}

protocol PasswordResetOutput: class {
    func resetPassword()
    func goToLogin()
}

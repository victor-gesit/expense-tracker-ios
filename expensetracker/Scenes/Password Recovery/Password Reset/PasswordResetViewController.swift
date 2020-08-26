//
//  PasswordResetViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 26/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class PasswordResetViewController: BaseViewController, PasswordResetInput {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: PasswordResetOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PasswordResetPresenter(view: self)
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        self.presenter?.goToLogin()
    }
    @IBAction func resetPassword(_ sender: UIButton) {
        self.presenter?.resetPassword()
    }
}

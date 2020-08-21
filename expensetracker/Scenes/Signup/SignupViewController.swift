//
//  SignupViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController, SignupInput {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: SignupOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignupPresenter(view: self)
    }
    
    @IBAction func goToLogin(_ sender: UIButton) {
        self.presenter?.goToLogin()
    }
    @IBAction func signUp(_ sender: UIButton) {
        self.presenter?.signUp()
    }
}

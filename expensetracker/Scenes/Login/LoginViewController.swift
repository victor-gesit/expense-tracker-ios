//
//  LoginViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginInput {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: LoginOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
    }
    
    @IBAction func logIn(_ sender: UIButton) {
    }
}
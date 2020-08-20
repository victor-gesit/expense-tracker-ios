//
//  SignupViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, SignupInput {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: SignupOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignupPresenter(view: self)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
    }
}

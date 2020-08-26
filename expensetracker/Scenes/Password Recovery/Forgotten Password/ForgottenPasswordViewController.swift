//
//  ForgottenPasswordViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 26/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class ForgottenPasswordViewController: UIViewController, ForgottenPasswordInput {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: ForgottenPasswordOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ForgottenPasswordPresenter(view: self)
    }
    
    @IBAction func recoverAccount(_ sender: UIButton) {
        self.presenter?.recoverAccount()
    }
}

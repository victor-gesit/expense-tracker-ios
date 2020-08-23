//
//  HomeViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {
    @IBOutlet weak var expensesContainerView: UIView!
    @IBOutlet weak var incomeContainerView: UIView!
    var presenter: HomeViewOutput?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        presenter?.signOut()
    }
}

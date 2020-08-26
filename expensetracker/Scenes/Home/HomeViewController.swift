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
    @IBOutlet weak var nameLabel: UILabel!
    var presenter: HomeViewOutput?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        presenter?.viewDidLoad()
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        presenter?.signOut()
    }
}

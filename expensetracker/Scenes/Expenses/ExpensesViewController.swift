//
//  ExpensesViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController, ExpensesViewInput {
    @IBOutlet weak var tableView: UITableView!
    var presenter: ExpensesViewOutput?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ExpensesViewPresenter(view: self)
        presenter?.viewDidLoad()
    }
}

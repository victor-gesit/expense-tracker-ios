//
//  PresenterProtocols.swift
//  expensetracker
//
//  Created by Victor Idongesit on 24/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol ExpensesViewInput: class {
    var tableView: UITableView! { get set }
    var view: UIView! { get set }
}

protocol ExpensesViewOutput: class {
    func viewDidLoad()
    func fetchExpenses()
}

protocol AddExpenseDelegate: class {
    func didCreateExpense(expense: Expense)
}

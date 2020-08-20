//
//  ExpensePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol ExpensesViewInput: class {
    var tableView: UITableView! { get set }
}

protocol ExpensesViewOutput: class {
}

class ExpensesViewPresenter: ExpensesViewOutput {
    weak var view: ExpensesViewInput?
    
    init(view: ExpensesViewInput) {
        self.view = view
    }
}

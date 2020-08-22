//
//  ExpenseViewPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
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

class ExpensesViewPresenter: NSObject {
    weak var view: ExpensesViewInput?
    var selectedRowIndex: Int?
    private let server = ExpenseAppServer.shared
    private var parentView: UIView?
    
    private var expenseCategories: [ExpenseCategory] = [] {
        didSet {
            view?.tableView.reloadData()
        }
    }
    
    init(view: ExpensesViewInput) {
        self.view = view
        self.parentView = view.view
    }
}

extension ExpensesViewPresenter: ExpensesViewOutput {
    func viewDidLoad() {
        setupTableView()
        fetchExpenses()
    }
    
    func fetchExpenses() {
        server.getExpenses {[weak self] (expenses, error) in
            if let error = error, let parentView = self?.parentView {
                Utility.showError(message: error.localizedDescription, view: parentView)
            }
            self?.expenseCategories =  Utility.groupExpensesByCategories(expenses ?? [])
        }
    }
    
    func setupTableView() {
        view?.tableView.delegate = self
        view?.tableView.dataSource = self
        view?.tableView.tableFooterView = UIView()
        view?.tableView.register(UINib(nibName: ExpenseTableViewCell.NIB_NAME, bundle: .main), forCellReuseIdentifier: Constants.expenseCellId)
        view?.tableView.register(UINib(nibName: ExpandedExpenseTableViewCell.NIB_NAME, bundle: .main), forCellReuseIdentifier: Constants.expandedExpenseCellId)
    }
}

extension ExpensesViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let selectedIndex = selectedRowIndex, selectedIndex == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expandedExpenseCellId, for: indexPath) as! ExpandedExpenseTableViewCell
            cell.expenseCategory = expenseCategories[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenseCellId, for: indexPath) as! ExpenseTableViewCell
        cell.expenseCategory = expenseCategories[indexPath.row]
        return cell
    }
}

extension ExpensesViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if expenseCategories[indexPath.row].expenses.isEmpty { return }
        self.selectedRowIndex = self.selectedRowIndex == indexPath.row ? nil : indexPath.row
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let index = selectedRowIndex, index == indexPath.row {
            return UITableView.automaticDimension
        }
        
        return 70
    }
}

extension ExpensesViewPresenter {
    struct Constants {
        static let expenseCellId = "expenseCellId"
        static let expandedExpenseCellId = "expandedExpenseCellId"
    }
}

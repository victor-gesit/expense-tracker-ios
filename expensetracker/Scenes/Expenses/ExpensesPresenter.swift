//
//  ExpensesViewPresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class ExpensesViewPresenter: NSObject {
    weak var view: ExpensesViewInput?
    var selectedRowIndex: Int?
    private let server = ExpenseAppServer.shared
    private var parentView: UIView
    
    private var expenseCategories: [ExpenseCategory] = []
    
    private var expenses: [Expense] = [] {
        didSet {
            self.expenseCategories =  Utility.groupExpensesByCategories(expenses)
            view?.tableView.reloadData()
        }
    }
    
    init(view: ExpensesViewInput) {
        self.view = view
        self.parentView = view.view
    }
}


// MARK: - ExpensesViewOutput

extension ExpensesViewPresenter: ExpensesViewOutput {
    func viewDidLoad() {
        setupTableView()
        fetchExpenses()
        Utility.toggleOverlayingLoader(show: true)
    }
    
    @objc
    func fetchExpenses() {
        server.getExpenses {[weak self] (result, error) in
            DispatchQueue.main.async {
                Utility.toggleOverlayingLoader(show: false)
                self?.view?.tableView.refreshControl?.endRefreshing()
            }
            guard let expenses = result else {
                Utility.showError(message: error?.localizedDescription, view: self?.parentView)
                return
            }
            self?.expenses = expenses
        }
    }
    
    func setupTableView() {
        view?.tableView.delegate = self
        view?.tableView.dataSource = self
        view?.tableView.tableFooterView = UIView()
        view?.tableView.register(UINib(nibName: ExpenseTableViewCell.NIB_NAME, bundle: .main), forCellReuseIdentifier: Constants.expenseCellId)
        view?.tableView.register(UINib(nibName: ExpandedExpenseTableViewCell.NIB_NAME, bundle: .main), forCellReuseIdentifier: Constants.expandedExpenseCellId)
        view?.tableView.register(UINib(nibName: AddCategoryTableViewCell.NIB_NAME, bundle: .main), forCellReuseIdentifier: Constants.addExpenseCategoryCellId)
        view?.tableView.refreshControl = UIRefreshControl()
        view?.tableView.refreshControl?.addTarget(self, action: #selector(fetchExpenses), for: .valueChanged)
    }
}

// MARK: - Table Datasource Functions

extension ExpensesViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseCategories.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == expenseCategories.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.addExpenseCategoryCellId, for: indexPath) as! AddCategoryTableViewCell
            return cell
        }
        if let selectedIndex = selectedRowIndex, selectedIndex == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expandedExpenseCellId, for: indexPath) as! ExpandedExpenseTableViewCell
            cell.expenseCategory = expenseCategories[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.expenseCellId, for: indexPath) as! ExpenseTableViewCell
        cell.expenseCategory = expenseCategories[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: - Table Delegate Functions

extension ExpensesViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == expenseCategories.count {
            openExpenseAdder(with: ExpenseCategory(expenses: [], category: nil))
            return
        }
    
        if expenseCategories[indexPath.row].expenses.isEmpty {
            openExpenseAdder(with: expenseCategories[indexPath.row])
            return
        }
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


// MARK: - Table Constants

extension ExpensesViewPresenter {
    struct Constants {
        static let expenseCellId = "expenseCellId"
        static let expandedExpenseCellId = "expandedExpenseCellId"
        static let addExpenseCategoryCellId = "addExpenseCategoryCellId"
    }
}

// MARK: - ExpenseTableCellDelegate

extension ExpensesViewPresenter: ExpenseTableCellDelegate {
    func openExpenseAdder(with category: ExpenseCategory) {
        let addExpenseVC = AddExpenseViewController.instantiate(fromAppStoryboard: .Main)
        addExpenseVC.delegate = self
        addExpenseVC.category = category
        (self.view as? UIViewController)?.present(addExpenseVC, animated: true)
    }
}

// MARK: - AddExpenseDelegate

extension ExpensesViewPresenter: AddExpenseDelegate {
    func didCreateExpense(expense: Expense) {
        self.expenses.append(expense)
        self.view?.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
}

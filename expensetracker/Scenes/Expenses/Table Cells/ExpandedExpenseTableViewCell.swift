//
//  ExpandedIncomeTableViewCell.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class ExpandedExpenseTableViewCell: UITableViewCell {
    static let NIB_NAME = "\(ExpandedExpenseTableViewCell.self)"
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var expensesStackView: UIStackView!
    
    var expenseCategory: ExpenseCategory? {
        didSet {
            setupExpenses()
        }
    }

    func setupExpenses() {
        titleContainerView.addHorizontalGradient(colorOne: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), colorTwo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), endPointX: 1)
        for view in expensesStackView.arrangedSubviews {
            expensesStackView.removeArrangedSubview(view)
        }
        guard let expenses = expenseCategory?.expenses else { return }
        for expense in expenses {
            let expenseItemView = ExpenseItemView(frame: .zero)
            expenseItemView.expense = expense
            expensesStackView.addArrangedSubview(expenseItemView)
        }
    }
}

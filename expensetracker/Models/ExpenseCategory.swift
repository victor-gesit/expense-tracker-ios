//
//  ExpenseCategory.swift
//  expensetracker
//
//  Created by Victor Idongesit on 23/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

class ExpenseCategory {
    var expenses: [Expense] = []
    var category: String?
    var inbuiltType: ExpenseType?
    static var allCategoriesExpense: Double = 0

    var totalExpense: Double {
        let totalExpenses: Double = expenses.reduce(0) { $0 + $1.amount }
        return totalExpenses
    }
    
    var percentage: Double? {
        if Self.allCategoriesExpense > 0 {
            return totalExpense/Self.allCategoriesExpense
        }
        return 0
    }
    
    init(expenses: [Expense], category: String?) {
        self.expenses = expenses
        self.category = category
        self.inbuiltType = ExpenseType.typeFromString(typeString: category)
    }
    
    static var inbuiltCategories: [ExpenseCategory] {
        return ExpenseType.allCases.compactMap {
            ExpenseCategory(expenses: [], category: $0.rawValue.capitalized)
        }
    }
    
}

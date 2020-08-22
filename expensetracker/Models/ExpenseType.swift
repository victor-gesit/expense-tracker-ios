//
//  ExpenseType.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

enum ExpenseType: String, CaseIterable {
    case travel
    case home
    case clothing
    case drinks
    case food
    case car
    case pets
    
    var icon: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    static var defaultIcon: UIImage? {
        return UIImage(named: "spending")
    }
    
    static func typeFromString(typeString: String?) -> ExpenseType? {
        return ExpenseType.allCases.first { $0.rawValue.lowercased() == typeString?.lowercased() }
    }
}

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

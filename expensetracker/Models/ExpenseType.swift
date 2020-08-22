//
//  ExpenseType.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

enum ExpenseType: String {
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
}

struct ExpenseCategory {
    var expenses: [Expense] = []
    
    var totalExpense: Double {
        let totalExpenses: Double = expenses.reduce(0) { $0 + $1.amount }
        return totalExpenses
    }
}

//
//  Expense.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

struct Expense: Codable {
    var purpose: String
    var id: String
    var category: String
    var amount: Double
    var month: Int
    var year: Int
    var createdAt: String?
}

struct ExpenseCreateResponse: Codable {
    var expense: Expense?
    var message: String
    var success: Bool
    var errors: [String]?
}

struct ExpenseFetchResponse: Codable {
    var expenses: [Expense]?
    var success: Bool
    var message: String
}

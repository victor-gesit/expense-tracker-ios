//
//  Endpoints.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

enum Route: CustomStringConvertible {
    case login
    case signup
    case createExpense
    case readExpenses
    case updateExpense
    case deleteExpense
    
    var description: String {
        get {
            switch self {
            case .login:
                return Constants.login
            case .signup:
                return Constants.signup
            case .readExpenses:
                return Constants.expenses
            case .updateExpense, .deleteExpense, .createExpense:
                return Constants.expense
            }
        }
    }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Constants {
    static let baseURL = "https://victor-expenses-backend.herokuapp.com/api/"
    
    
    static let login = Constants.baseURL + "signin"
    static let signup = Constants.baseURL + "signup"
    static let expenses = Constants.baseURL + "expenses"
    static let expense = Constants.baseURL + "expense"
}

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
    case readExpense
    case updateExpense
    case deleteExpense
    
    var description: String {
        get {
            switch self {
            case .login:
                return Constants.login
            case .signup:
                return Constants.signup
            case .createExpense:
                return Constants.createExpense
            case .readExpense:
                return Constants.createExpense
            case .updateExpense:
                return Constants.updateExpense
            case .deleteExpense:
                return Constants.deleteExpense
            }
        }
    }
    
    struct Constants {
        static let login = ""
        static let signup = ""
        static let createExpense = ""
        static let updateExpense = ""
        static let deleteExpense = ""
    }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

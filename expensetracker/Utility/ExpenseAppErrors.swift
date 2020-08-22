//
//  ExpenseAppErrors.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

enum ExpenseAppErrors: Error {
    case unknownError
    case noNetwork
    case signupFailed(String?)
    case loginFailed(String?)
    case getExpensesFailed(String?)
}

extension ExpenseAppErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownError: return String.ErrorMessages.unknownError
        case .noNetwork: return String.ErrorMessages.noInternetConnection
        case .signupFailed(let reason): return reason ?? String.ErrorMessages.unknownError
        case .loginFailed(let reason): return reason ?? String.ErrorMessages.unknownError
        case .getExpensesFailed(let reason): return reason ?? String.ErrorMessages.unknownError
        }
    }
}

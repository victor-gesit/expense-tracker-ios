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
    case signupFailed(String)
    case loginFailed(String)
}

extension ExpenseAppErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownError: return "Unknown error"
        case .noNetwork: return "Cannot connect to the internet"
        case .signupFailed(let reason): return reason
        case .loginFailed(let reason): return reason
        }
    }
}

//
//  String+Extensions.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let email = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPasswordText() -> Bool {
        return self.count >= 2
    }
    
    static var emptyString: String {
        get {
            return ""
        }
    }
    
    struct ErrorMessages {
        static let invalidEmail = "Email is invalid"
        static let missingFields = "Missing fields"
        static let passwordError = "Password is too short"
        static let invalidAmount = "Invalid amount entered"
        static let unknownError = "Unknown Error"
        static let noInternetConnection = "Cannot connect to the internet"
    }
    
    struct PageTitle {
        static let addCategory = "Add Expense Category"
        static let addExpense = "Add Expense"
    }
}

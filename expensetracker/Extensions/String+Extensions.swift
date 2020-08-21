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
    
    struct ErrorMessages {
        static let invalidEmail = "Email is invalid"
        static let missingFields = "Missing fields"
        static let passwordError = "Password is too short"
    }
}

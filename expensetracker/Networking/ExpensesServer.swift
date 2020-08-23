//
//  ExpensesServer.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension ExpenseAppServer {
    func createExpense(category: String, purpose: String, amount: Double, completion: @escaping (Expense?, Error?) -> Void) {
        let parameters: [String: Any] = [
            "category": category,
            "purpose": purpose,
            "amount": amount
        ]
        makeAPICall(route: .createExpense, method: .post, paramaters: parameters, type: ExpenseCreateResponse.self) { (data, response, error, result) in
            
            completion(result?.expense, result?.success ?? false ? nil : ExpenseAppErrors.getExpensesFailed(result?.message))
        }
    }
    
    func updateExpense(expenseId: String, amount: Double) {
    }
    
    func deleteExpense(expenseId: String) {
    }
    
    func getExpenses(completion: @escaping ([Expense]?, Error?) -> Void) {
        makeAPICall(route: .readExpenses, method: .get, type: ExpenseFetchResponse.self) { (data, response, error, result) in
            completion(result?.expenses, result?.success ?? false ? nil : ExpenseAppErrors.getExpensesFailed(result?.message))
        }
    }
}

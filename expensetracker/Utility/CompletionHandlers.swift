//
//  CompletionHandlers.swift
//  expensetracker
//
//  Created by Victor Idongesit on 26/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

typealias MessageNotificationCompletionHandler = (() -> Void)?
typealias UserAuthenticationCompletionHandler = (User?, Error?) -> Void
typealias AccountRecoveryCompletionHandler = (Error?) -> Void
typealias ExpenseCreationCompletionHandler = (Expense?, Error?) -> Void
typealias ExpensesFetchCompletionHandler = ([Expense]?, Error?) -> Void

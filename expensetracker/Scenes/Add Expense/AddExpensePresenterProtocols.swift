//
//  PresenterProtocols.swift
//  expensetracker
//
//  Created by Victor Idongesit on 24/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol AddExpenseViewInput: class {
    var view: UIView! { get set }
    var categoryIcon: UIImageView! { get set }
    var categoryLabel: UILabel! { get set }
    var amountTextField: UITextField! { get set }
    var descriptionTextField: UITextField! { get set }
    var submitButton: UIButton! { get set }
    var activityIndicator: UIActivityIndicatorView! { get set }
    var categoryTextField: UITextField! { get set }
    var titleContainerView: UIView! { get set }
    var category: ExpenseCategory? { get set }
    var delegate: AddExpenseDelegate? { get set }
    var inputStackView: UIStackView! { get set }
    var pageTitleLabel: UILabel! { get set }
}

protocol AddExpenseOutput: class {
    func submitExpense()
    func viewDidLayoutSubviews()
    func viewDidLoad()
}

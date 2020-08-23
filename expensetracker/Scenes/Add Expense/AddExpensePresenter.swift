//
//  AddExpensePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 23/08/2020.
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
    var titleContainerView: UIView! { get set }
    var category: ExpenseCategory? { get set }
    var delegate: AddExpenseDelegate? { get set }
}

protocol AddExpenseOutput: class {
    func submitExpense()
    func viewDidLoad()
}

class AddExpensePresenter {
    weak var view: AddExpenseViewInput?
    var parentView: UIView
    private let server = ExpenseAppServer.shared
    
    init(view: AddExpenseViewInput) {
        self.view = view
        self.parentView = view.view
    }
    
    private func toggleButton(enable: Bool) {
        self.view?.submitButton.isEnabled = enable
        enable ? self.view?.activityIndicator.stopAnimating() : self.view?.activityIndicator.startAnimating()
    }
    
    private func setupView() {
        view?.categoryIcon.image = view?.category?.inbuiltType?.icon ?? ExpenseType.defaultIcon
        view?.categoryLabel.text = view?.category?.category
        view?.titleContainerView.addHorizontalGradient(colorOne: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), colorTwo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), endPointX: 1)
    }
    
    private func dismissView() {
        (self.view as? UIViewController)?.dismiss(animated: true)
    }
}

// MARK: - AddExpenseOutput

extension AddExpensePresenter: AddExpenseOutput {
    func viewDidLoad() {
        setupView()
    }
    
    func submitExpense() {
        validateAndSubmit()
    }
    
    private func validateAndSubmit() {
        guard let view = self.view else { return }
        if let amount = view.amountTextField.text, !amount.isEmpty,
            let category = view.category?.category {
            guard let amount = Double(amount) else {
                Utility.showError(message: String.ErrorMessages.invalidAmount, view: self.parentView)
                return
            }
            
            let description = view.descriptionTextField.text ?? String.emptyString
            toggleButton(enable: false)
            server.createExpense(category: category, purpose: description, amount: amount) { (result, error) in
                self.toggleButton(enable: true)
                guard let expense = result else {
                    Utility.showError(message: error?.localizedDescription, view: self.parentView)
                    return
                }
                self.view?.delegate?.didCreateExpense(expense: expense)
                self.dismissView()
            }
        } else {
            Utility.showError(message: String.ErrorMessages.missingFields, view: self.parentView)
        }
    }
}

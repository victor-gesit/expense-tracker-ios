//
//  AddExpensePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 23/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

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
        view?.pageTitleLabel.text = view?.category?.category == nil
            ? String.PageTitle.addCategory : String.PageTitle.addExpense
        
        if let _ = view?.category?.category,
            let categoryInputField = view?.categoryTextField {
            view?.inputStackView.removeArrangedSubview(categoryInputField)
        }
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
    
    func viewDidLayoutSubviews() {
        view?.titleContainerView.addHorizontalGradient(colorOne: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), colorTwo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), endPointX: 1)
    }
    
    func submitExpense() {
        validateAndSubmit()
    }
    
    private func validateAndSubmit() {
        guard let view = self.view else { return }
        if let amount = view.amountTextField.text, !amount.isEmpty,
            let category = view.category?.category ?? view.categoryTextField.text {
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

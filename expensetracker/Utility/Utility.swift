//
//  Utility.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    static func showNotification(message: String?, view: UIView?, isError: Bool = false, completion: MessageNotificationCompletionHandler = nil ) {
        guard let messageString = message, !messageString.isEmpty else { return }
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        errorView.backgroundColor = isError ? #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1) : #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        
        let errorLabel = UILabel(frame: errorView.bounds)
        errorLabel.text = message
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .white
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textAlignment = .center
        
        errorView.addSubview(errorLabel)
        
        let mainWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        mainWindow?.addSubview(errorView)
        
        UIView.animate(withDuration: 0.25, delay: 1, options: [.curveEaseOut], animations: {
            errorView.alpha = 0
        }) { (_) in
            errorView.removeFromSuperview()
        }
    }
    
    static func toggleOverlayingLoader(show: Bool) {
        guard let mainWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        if !show {
            let overlay = mainWindow.subviews.first(where: {$0.tag == Int.AppViewTags.loaderOverlayViewTag})
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                overlay?.alpha = 0
            }) { (_) in
                overlay?.removeFromSuperview()
            }
            return
        }
        
        let overlayingView = UIView(frame: UIScreen.main.bounds)
        overlayingView.alpha = 0.5
        overlayingView.backgroundColor = .lightGray
        
        let loader = UIActivityIndicatorView(frame: mainWindow.frame)
        loader.tintColor = .black
        loader.style = .large
        loader.startAnimating()
        overlayingView.addSubview(loader)
        
        overlayingView.tag = Int.AppViewTags.loaderOverlayViewTag
        
        mainWindow.addSubview(overlayingView)
    }
    
    static func goHome() {
        HomeViewController.makeRootViewController(storyboard: .Main)
    }
    
    static func goToLogin() {
        LoginViewController.makeRootViewController(storyboard: .Main)
    }
    
    static func openPasswordReset() {
        PasswordResetViewController.makeRootViewController(storyboard: .Main)
    }
    
    static func signOut(parentVC: UIViewController?) {
        let alertController = UIAlertController(title: "Sign out", message: "You will be signed out of the application.", preferredStyle: .alert)
        let signoutAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            UserDefaults.standard.signedInUser = nil
            UserDefaults.standard.authToken = nil
            LoginViewController.makeRootViewController(storyboard: .Main)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(signoutAction)
        alertController.addAction(cancelAction)
        
        parentVC?.present(alertController, animated: true, completion: nil)
    }
    
    static func groupExpensesByCategories(_ expenses: [Expense]) -> [ExpenseCategory] {
        var categories: [ExpenseCategory] = ExpenseCategory.inbuiltCategories
        ExpenseCategory.allCategoriesExpense = 0
        for expense in expenses {
            if let category = categories.first(where: { (expenseCategory) -> Bool in
                expenseCategory.category?.lowercased() == expense.category.lowercased()
            }) {
                category.expenses.append(expense)
                ExpenseCategory.allCategoriesExpense += expense.amount
            } else {
                let categoryString = expense.category.capitalized
                let cat = ExpenseCategory(expenses: [expense], category: categoryString)
                ExpenseCategory.allCategoriesExpense += expense.amount
                categories.append(cat)
            }
        }
        return categories.sorted {
            $0.totalExpense > $1.totalExpense
        }
    }
}

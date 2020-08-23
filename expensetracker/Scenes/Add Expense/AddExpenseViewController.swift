//
//  AddExpenseViewController.swift
//  expensetracker
//
//  Created by Victor Idongesit on 23/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class AddExpenseViewController: BaseViewController, AddExpenseViewInput {
    var category: ExpenseCategory?
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleContainerView: UIView!
    
    weak var delegate: AddExpenseDelegate?
    var presenter: AddExpenseOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddExpensePresenter(view: self)
        presenter?.viewDidLoad()
    }
    
    @IBAction func addExpense(_ sender: UIButton) {
        presenter?.submitExpense()
    }
}

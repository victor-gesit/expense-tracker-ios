//
//  ExpenseItemView.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class ExpenseItemView: UIView {
    @IBOutlet var contentView: UIView!
    static let NIB_NAME = "ExpenseItemView"
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    var expense: Expense? {
        didSet {
            descriptionLabel.text = expense?.purpose
            dateLabel.text = Date.dateAndMonthFromString(expense?.createdAt ?? String.emptyString)
            amountLabel.text = expense?.amount.toCurrency(.naira)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(ExpenseItemView.NIB_NAME, owner: self, options: nil)
        contentView.fitInView(self)
    }
}

//
//  ExpenseTableViewCell.swift.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    static let NIB_NAME = "\(ExpenseTableViewCell.self)"
    
    @IBOutlet var percentageContainerView: UIView!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var expenseCategoryLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var delegate: ExpenseTableCellDelegate?

    var expensePercentage: CGFloat = 0
    var expenseCategory: ExpenseCategory? {
        didSet {
            expensePercentage = 0
            categoryIcon.image = expenseCategory?.inbuiltType?.icon ?? ExpenseType.defaultIcon
            expenseCategoryLabel.text = expenseCategory?.category
            expensePercentage = CGFloat(expenseCategory?.percentage ?? 0)
            percentageLabel.text = expenseCategory?.percentage?.toPercentageString()
            setupPercentage()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
        setupPercentage()
    }
    
    func setupPercentage() {
        if let previousPercentageView =
            percentageContainerView.subviews.first(where: {$0.tag == 888}) {
            previousPercentageView.removeFromSuperview()
        }
        
        let percentageViewHeight = percentageContainerView.frame.height
        let percentageViewWidth = (expensePercentage * (percentageContainerView.frame.width - percentageViewHeight)) + percentageViewHeight
        let gradientEndpointX = percentageContainerView.frame.width / percentageViewWidth
        
        let percentageGradientView = UIView(frame: CGRect(x: 0, y: 0, width: percentageViewWidth, height: percentageViewHeight))
        percentageGradientView.addHorizontalGradient(colorOne: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), colorTwo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), endPointX: gradientEndpointX)
        percentageGradientView.roundCorners(corners: [.topRight, .bottomRight], radius: percentageViewHeight/2)
        percentageGradientView.tag = Int.AppViewTags.horizontalLayerGradientTag
        self.percentageContainerView.addSubview(percentageGradientView)
    }
    
    func setupContainerView() {
        selectionStyle = .none
        percentageContainerView.layer.cornerRadius = 4
        percentageContainerView.layer.masksToBounds = true
    }
    
    
    @IBAction func addExpense(sender: UIButton) {
        guard let category = expenseCategory else { return }
        delegate?.openExpenseAdder(with: category)
    }
}

protocol ExpenseTableCellDelegate {
    func openExpenseAdder(with category: ExpenseCategory)
}

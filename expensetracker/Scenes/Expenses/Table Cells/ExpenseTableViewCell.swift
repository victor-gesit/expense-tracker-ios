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
    
    var expensePercentage: CGFloat = 0.5
    var expenseCategory: ExpenseCategory = .home
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPercentage()
        setupContainerView()
    }
    
    func setupPercentage() {
        let percentageViewHeight = percentageContainerView.frame.height
        let percentageViewWidth = (expensePercentage * (percentageContainerView.frame.width - percentageViewHeight)) + percentageViewHeight
        let gradientEndpointX = percentageContainerView.frame.width / percentageViewWidth
        let percView = UIView(frame: CGRect(x: 0, y: 0, width: percentageViewWidth, height: percentageViewHeight))
        percView.addHorizontalGradient(colorOne: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), colorTwo: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), endPointX: gradientEndpointX)
        percView.roundCorners(corners: [.topRight, .bottomRight], radius: percentageViewHeight/2)
        self.percentageContainerView.addSubview(percView)
    }
    
    func setupContainerView() {
        percentageContainerView.layer.cornerRadius = 4
        percentageContainerView.layer.masksToBounds = true
        categoryIcon.image = expenseCategory.icon
    }
    
    
    @IBAction func addExpense(sender: UIButton) {
        
    }
}
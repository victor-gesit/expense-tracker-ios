//
//  AddCategoryTableViewCell.swift
//  expensetracker
//
//  Created by Victor Idongesit on 23/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import UIKit

class AddCategoryTableViewCell: UITableViewCell {
    static let NIB_NAME = "\(AddCategoryTableViewCell.self)"

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

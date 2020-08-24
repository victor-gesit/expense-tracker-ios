//
//  IncomePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

class IncomeViewPresenter: IncomeViewOutput {
    weak var view: IncomeViewInput?
    
    init(view: IncomeViewInput) {
        self.view = view
    }
}

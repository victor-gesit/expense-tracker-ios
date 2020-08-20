//
//  HomePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

protocol HomeViewInput: class {
    
}

protocol HomeViewOutput: class {
    
}

class HomePresenter: HomeViewOutput {
    weak var view: HomeViewInput?
    
    init(view: HomeViewInput) {
        self.view = view
    }
}

//
//  HomePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewInput: class {
    var view: UIView! { get set }
}

protocol HomeViewOutput: class {
    func signOut()
}

class HomePresenter {
    weak var view: HomeViewInput?
    
    init(view: HomeViewInput) {
        self.view = view
    }
}

extension HomePresenter: HomeViewOutput {
    func signOut() {
        Utility.signOut(parentVC: (self.view as? UIViewController))
    }
}

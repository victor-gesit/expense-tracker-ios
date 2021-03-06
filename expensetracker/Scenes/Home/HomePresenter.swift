//
//  HomePresenter.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

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
    func viewDidLoad() {
        (self.view as? UIViewController)?.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view?.nameLabel.text = UserDefaults.standard.signedInUser?.name.firstNameGreeting
    }
}

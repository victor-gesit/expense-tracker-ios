//
//  PresenterProtocols.swift
//  expensetracker
//
//  Created by Victor Idongesit on 24/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewInput: class {
    var view: UIView! { get set }
    var nameLabel: UILabel! { get set }
}

protocol HomeViewOutput: class {
    func signOut()
    func viewDidLoad()
}

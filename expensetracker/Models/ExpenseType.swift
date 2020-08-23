//
//  ExpenseType.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

enum ExpenseType: String, CaseIterable {
    case travel
    case home
    case clothing
    case drinks
    case food
    case car
    case pets
    case commute
    
    var icon: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    static var defaultIcon: UIImage? {
        return UIImage(named: "spending")
    }
    
    static func typeFromString(typeString: String?) -> ExpenseType? {
        return ExpenseType.allCases.first { $0.rawValue.lowercased() == typeString?.lowercased() }
    }
}

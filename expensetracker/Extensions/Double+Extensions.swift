//
//  Double+Extensions.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension Double {
    func toCurrency(_ currency: Currency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency.rawValue
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        let currencyString = formatter.string(from: NSNumber(value: self))
        return currencyString ?? String(format: "%.2f", self)
    }
    
    func toPercentageString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let percentageString = formatter.string(from: NSNumber(value: self))
        return percentageString
    }
}

enum Currency: String {
    case naira = "₦"
    case pounds = "£"
    case dollars = "€"
    case euros = "$"
    case yen = "¥"
    case cedi = "GH₵"
}

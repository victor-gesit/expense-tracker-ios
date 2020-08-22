//
//  Date+Extensions.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension Date {
    static func dateAndMonthFromString(_ string: String) -> String {
        let convertedDate = dateFromString(string)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        if let date = convertedDate {
            return dateFormatter.string(from: date)
        } else {
            return "Unknown date."
        }
    }
    
    static private func dateFromString(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: string)
        return date
    }
}

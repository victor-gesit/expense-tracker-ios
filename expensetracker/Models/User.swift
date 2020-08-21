//
//  User.swift
//  expensetracker
//
//  Created by Victor Idongesit on 20/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

struct User: Codable {
    var email: String
    var name: String
    var id: String
}

struct UserAuthResponse: Codable {
    var user: User?
    var success: Bool
    var token: String?
    var errors: [String]?
    var message: String?
}

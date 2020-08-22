//
//  UserDefaults+Extensions.swift
//  expensetracker
//
//  Created by Victor Idongesit on 22/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation

extension UserDefaults {
    private enum Keys: String {
        case signedInUser
    }
    
    var signedInUser: User? {
        get {
            if let userObjectData = object(forKey: Keys.signedInUser.rawValue) as? Data {
                return try? JSONDecoder().decode(User.self, from: userObjectData)
            }
            return nil
        }

        set {
            if let user = newValue, let data = try? JSONEncoder().encode(user) {
                set(data, forKey: Keys.signedInUser.rawValue)
            } else {
                removeObject(forKey: Keys.signedInUser.rawValue)
            }
        }
    }
}

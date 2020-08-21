//
//  Utility.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    static func showError(message: String?, view: UIView) {
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        errorView.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        
        let errorLabel = UILabel(frame: errorView.bounds)
        errorLabel.text = message
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .white
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.textAlignment = .center
        
        errorView.addSubview(errorLabel)
        
        let mainWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        mainWindow?.addSubview(errorView)
        
        UIView.animate(withDuration: 0.25, delay: 1, options: [.curveEaseOut], animations: {
            errorView.alpha = 0
        }) { (_) in
            errorView.removeFromSuperview()
        }
    }
}

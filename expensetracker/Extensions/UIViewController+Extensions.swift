//
//  UIViewController+Extensions.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var storyboardID: String {
        return "\(self)"
    }
    
    public static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard, withIdentifier identifier: String? = nil) -> Self {
        return appStoryboard.viewController(viewControllerClass: self, identifier: identifier)
    }
    
    static func makeRootViewController(storyboard: AppStoryboard) {
        let mainViewController = self.instantiate(fromAppStoryboard: storyboard)
        let rootVC = UINavigationController(rootViewController: mainViewController)
        let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}

public enum AppStoryboard: String {
    case Main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type, identifier: String? = nil) -> T {
        let storyboardId = identifier ?? viewControllerClass.storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardId) as? T else {
            fatalError("Viewcontroller with ID \(storyboardId), not found in \(self.rawValue) Storyboard")
        }
        return scene
    }
}

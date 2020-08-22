//
//  UIView+Extensions.swift
//  expensetracker
//
//  Created by Victor Idongesit on 21/08/2020.
//  Copyright © 2020 Victor Idongesit. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addHorizontalGradient(colorOne: UIColor, colorTwo: UIColor, endPointX: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: 0.5)
        gradientLayer.name = "horizontalGradient"
        if let previousGradient = self.layer.sublayers?.first(where: {
            $0.name == "horizontalGradient"
        }) {
            previousGradient.removeFromSuperlayer()
        }
        self.layer.addSublayer(gradientLayer)
        layer.masksToBounds = true
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.masksToBounds = true
    }
    
    func fitInView(_ container: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        self.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }
}

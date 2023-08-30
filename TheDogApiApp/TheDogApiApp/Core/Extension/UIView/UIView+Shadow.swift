//
//  UIView+Shadow.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

extension UIView {
    
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.15,
                   width: CGFloat = 0,
                   height: CGFloat = 7,
                   radius: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
    }
    
}


//
//  UITextField+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/28.
//

import UIKit

extension UITextField {
    
    /// placeHolder with color
    /// - Parameters:
    ///   - placeHolderValue: placeHolder
    ///   - color: color
    /// - Returns: void
    func placeHolder(_ placeHolderValue: String, color: UIColor) -> Void {
        attributedPlaceholder = NSAttributedString.init(string: placeHolderValue, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    /// placeHolder with font
    /// - Parameters:
    ///   - placeHolderValue: placeHolder
    ///   - font: font
    /// - Returns: void
    func placeHolder(_ placeHolderValue: String, font: UIFont) -> Void {
        attributedPlaceholder = NSAttributedString.init(string: placeHolderValue, attributes: [NSAttributedString.Key.font: font])
    }
}




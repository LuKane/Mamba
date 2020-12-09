//
//  UIBarButtonItem+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/9.
//

import UIKit

extension UIBarButtonItem {
    
    /// create BarButtonItem with image, size, target,action
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(image: UIImage?,
                    size: CGSize,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        return item(image: image, size: size, bgSize: CGSize(width: 44, height: 44), target: target, action: action)
    }
    
    /// create BarButtonItem with image , size, bgSize, target, action
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - bgSize: bgsize
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(image: UIImage?,
                    size: CGSize,
                    bgSize: CGSize,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        let btn = UIButton.init(type: .custom)
        btn.setBackgroundImage(image, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: bgSize.width, height: bgSize.height))
        v.addSubview(btn)
        btn.origin = CGPoint(x: (bgSize.width - size.width) * 0.5, y: (bgSize.height - size.height) * 0.5)
        return self.init(customView: v)
    }
    
    
    /// create BarButtonItem with title, target, action
    /// - Parameters:
    ///   - title: title
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(title: String?,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        return item(title: title, color: .black, font: .systemFont(ofSize: 15), isLeft: false, size: CGSize(width: 40, height: 30), target: target, action: action)
    }
    
    /// create BarButtonItem with title , color, target, action
    /// - Parameters:
    ///   - title: title
    ///   - color: color
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(title: String?,
                    color: UIColor?,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        return item(title: title, color: color, font: .systemFont(ofSize: 15), isLeft: false, size: CGSize(width: 40, height: 30), target: target, action: action)
    }
    
    /// create BarButtonItem with title , font, color, target, action
    /// - Parameters:
    ///   - title: title
    ///   - color: color
    ///   - font: font
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(title: String?,
                    color: UIColor?,
                    font: UIFont,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        return item(title: title, color: color, font: font, isLeft: false, size: CGSize(width: 40, height: 30), target: target, action: action)
    }
    
    /// create BarButtonItem with title , font , size, color, target, action
    /// - Parameters:
    ///   - title: title
    ///   - color: color
    ///   - font: font
    ///   - size: size
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(title: String?,
                    color: UIColor?,
                    font: UIFont,
                    size: CGSize,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        return item(title: title, color: color, font: font, isLeft: false, size: size, target: target, action: action)
    }
    
    /// create BarButtonItem with title , font, isLeft , size, color, target, action
    /// - Parameters:
    ///   - title: title
    ///   - color: color
    ///   - font: font
    ///   - isLeft: text alignment is left or not
    ///   - size: size
    ///   - target: target
    ///   - action: action
    /// - Returns: UIBarButtonItem
    class func item(title: String?,
                    color: UIColor?,
                    font: UIFont,
                    isLeft: Bool,
                    size: CGSize,
                    target: Any?,
                    action: Selector) -> UIBarButtonItem {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = font
        btn.titleLabel?.textAlignment = isLeft ? .left : .right
        btn.addTarget(target, action: action, for: .touchUpInside)
        return self.init(customView: btn)
    }
}

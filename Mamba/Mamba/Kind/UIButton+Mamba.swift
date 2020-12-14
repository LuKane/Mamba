//
//  UIButton+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/14.
//

import UIKit

extension UIButton {
    struct AssociateKeys {
        static var key: Void?
    }
    /// add Target with action , if action == nil, it will replace you added target before
    /// - Parameters:
    ///   - event: event
    ///   - callBack: callback
    /// - Returns: void
    func addTarget(event: UIControl.Event, callBack: ((UIButton) -> Void)?) -> Void {
        objc_setAssociatedObject(self, &AssociateKeys.key, callBack, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(buttonDidClick(button:)), for: event)
    }
    
    @objc private func buttonDidClick(button: UIButton) -> Void {
        if let callBack = objc_getAssociatedObject(self, &AssociateKeys.key) as? ((UIButton) -> Void) {
            callBack(button)
        }
    }
}

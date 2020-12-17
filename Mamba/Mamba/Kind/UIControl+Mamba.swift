//
//  UIControl+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/17.
//

import UIKit

extension UIControl {
    struct AssociateKeys {
        static var key: Void?
    }
    
    /// UIControl addTarget with event and callBack
    /// - Parameters:
    ///   - event: event
    ///   - callBack: callBack
    /// - Returns: Void
    func addTarget(event: UIControl.Event, callBack: ((UIControl) -> Void)?) -> Void {
        objc_setAssociatedObject(self, &AssociateKeys.key, callBack, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(controlDidTarget(control:)), for: event)
    }
    
    @objc private func controlDidTarget(control: UIControl) -> Void {
        if let callBack = objc_getAssociatedObject(self, &AssociateKeys.key) as? ((UIControl) -> Void) {
            callBack(control)
        }
    }
}

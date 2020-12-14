//
//  UIGestureRecognizer+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/14.
//

import UIKit

extension UIGestureRecognizer {
    private struct AssociateKeys {
        static var key: Void?
    }
    
    /// add Target with action , if action == nil, it will replace you added target before
    /// - Parameter callBack: action
    func addTarget(callBack: ((UIGestureRecognizer) -> Void)?) -> Void {
        objc_setAssociatedObject(self, &AssociateKeys.key, callBack, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(gestureRecognizerDidClick(gestureRecognizer:)))
    }
    @objc private func gestureRecognizerDidClick(gestureRecognizer: UIGestureRecognizer)-> Void {
        if let callBack = objc_getAssociatedObject(self, &AssociateKeys.key) as? ((UIGestureRecognizer) -> Void){
            callBack(gestureRecognizer)
        }
    }
}


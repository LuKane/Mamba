//
//  UIButton+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2021/1/13.
//
/*
 * If you need to use delay btn , you should set "UIButton.loadSwift()" in the "AppDelegate.swift"
 */

import UIKit

private var delayTimeKey = "delayTimeKey"
private var isIgnoreEventKey = "isIgnoreEventKey"
private var defaultBtnTime: TimeInterval = 0.0

extension UIButton {
    
    var delayTime: TimeInterval {
        set {
            objc_setAssociatedObject(self, &delayTimeKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let delayTime = objc_getAssociatedObject(self, &delayTimeKey) as? TimeInterval {
                return delayTime
            }
            return defaultBtnTime
        }
    }
    
    @objc private func sendActionSelf(_ action: Selector,to target: Any?, for event :UIEvent?) {
        var clickTime = 0
        if self.delayTime == 0 {
            clickTime = Int(defaultBtnTime)
        }else {
            clickTime = Int(self.delayTime)
        }
        if clickTime != 0 {
            isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(clickTime)) { [weak self] in
                self?.isUserInteractionEnabled = true
            }
        }
        sendActionSelf(action, to: target, for: event)
    }
    
    public static func loadSwift() {
        if self !== UIButton.self {
            return
        }
        
        DispatchQueue.once(token: "DelayBtn") {
            let originalSeletor = #selector(sendAction)
            let swizzledSeletor = #selector(sendActionSelf)
            
            let originalMethod = class_getInstanceMethod(UIButton.self, originalSeletor)
            let swizzledMethod = class_getInstanceMethod(UIButton.self, swizzledSeletor)
            
            let addMethod = class_addMethod(UIButton.self, originalSeletor, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            
            if addMethod {
                class_replaceMethod(UIButton.self, swizzledSeletor, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            }else{
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
}

extension DispatchQueue {
    private static var _onceToken = [String]()
    public static func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceToken.contains(token) {
            return
        }
        _onceToken.append(token)
        block()
    }
}

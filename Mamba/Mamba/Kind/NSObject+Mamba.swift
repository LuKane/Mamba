//
//  NSObject+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/30.
//

import Foundation

extension NSObject {
    /// setAssociatedObject
    /// - Parameters:
    ///   - obj: obj
    ///   - key: key
    ///   - value: value
    ///   - policy: policy
    /// - Returns: void
    func setAssociatedObject(obj: Any, key: UnsafeRawPointer, value: AnyObject!, policy: objc_AssociationPolicy) -> Void {
        objc_setAssociatedObject(obj, key, value, policy)
    }
    /// getAssociatedObject
    /// - Parameters:
    ///   - objc: obj
    ///   - key: key
    /// - Returns: objc
    func getAssociatedObject(objc: Any, key: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(objc, key)
    }
    
    /// remove all associated
    /// - Parameter obj: obj
    /// - Returns: void
    func removeAllAssociatedObjects(obj: Any) -> Void {
        objc_removeAssociatedObjects(obj)
    }
    
    /// Object class name
    /// - Returns: Object class name
    class func className() -> String {
        return NSStringFromClass(self)
    }
    
    /// object class name
    /// - Returns: object class name
    func className() -> String {
        return NSString.init(utf8String: class_getName(type(of: self)))! as String
    }
    
}

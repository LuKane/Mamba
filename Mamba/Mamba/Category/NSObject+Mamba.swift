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
    
    func MethodListLogger() -> String {
        return MethodListLoggerClass(cls: object_getClass(self)!)
    }
    func MethodListLoggerClass(cls: AnyClass) -> String {
        var str = ""
        var count: UInt32 = 0
        let methodList = class_copyMethodList(cls, &count)
        
        guard methodList != nil else {
            return NSStringFromClass(cls) + "\n" + str
        }
        
        for i in 0..<count {
            let method = methodList![Int(i)]
            let methodString = NSStringFromSelector(method_getName(method))
            if i == 0 {
                str = "\(i) method: " + methodString + "\n"
            }else {
                str = str + "\(i) method: " + methodString + "\n"
            }
        }
        free(methodList)
        return NSStringFromClass(cls) + "\n" + str
    }
    
    func IvarListLogger() -> String {
        return IvarListLogger(cls: object_getClass(self)!)
    }
    func IvarListLogger(cls: AnyClass) -> String {
        var count: UInt32 = 0
        var str = ""
        let ivarList = class_copyIvarList(cls, &count)
        
        guard ivarList != nil else {
            return NSStringFromClass(cls) + "\n" + str
        }
        
        for i in 0..<count {
            let ivar = ivarList![Int(i)]
            let ivarName = ivar_getName(ivar)
            if i == 0 {
                str = "\(i) ivar: " + String(cString: ivarName!) + "\n"
            }else {
                str = str + "\(i) ivar: " + String(cString: ivarName!) + "\n"
            }
        }
        free(ivarList)
        return NSStringFromClass(cls) + "\n" + str
    }
    
    func PropertyListLogger() -> String {
        return PropertyListLogger(cls: object_getClass(self)!)
    }
    func PropertyListLogger(cls: AnyClass) -> String {
        var count: UInt32 = 0
        var str = ""
        let propertyList = class_copyPropertyList(cls, &count)
        
        guard propertyList != nil else {
            return NSStringFromClass(cls) + "\n" + str
        }
        
        for i in 0..<count {
            let property = propertyList![Int(i)]
            let propertyName = property_getName(property)
            if i == 0 {
                str = "\(i) property: " + String(cString: propertyName) + "\n"
            }else {
                str = str + "\(i) property: " + String(cString: propertyName) + "\n"
            }
        }
        free(propertyList)
        return NSStringFromClass(cls) + "\n" + str
    }
}

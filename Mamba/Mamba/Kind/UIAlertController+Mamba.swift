//
//  UIAlertController+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/12/23.
//

import UIKit

extension UIAlertController {
    
    /// alert on viewcontroller with one action
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - actionTitle: action title
    ///   - callBack: callBack
    /// - Returns: void
    class func alert(title: String?, message: String?, actionTitle: String?, callBack: @escaping (Int)->()) -> Void {
        alert(title: title, message: message, actionTitle: actionTitle, presentOn: UIApplication.shared.keyWindow?.rootViewController, callBack: callBack)
    }
    
    /// alert on viewcontroller with one action
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - actionTitle: actionTitle
    ///   - presentOn: on viewcontroller, default is window.rooterController
    ///   - callBack: callBack
    /// - Returns: void
    class func alert(title: String?, message: String?, actionTitle: String?, presentOn: UIViewController?, callBack: @escaping (Int)->()) -> Void {
        let alertVc = self.init(title: title, message: message, preferredStyle: .alert)
        let sureAct = UIAlertAction.init(title: actionTitle, style: .default) { (_) in
            callBack(0)
        }
        alertVc.addAction(sureAct)
        presentOn?.present(alertVc, animated: true, completion: {
            
        })
    }
    
    /// alert on viewcontroller with two action
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - leftActionTitle: left  title
    ///   - rightActionTitle: right title
    ///   - callBack: callback
    /// - Returns: void
    class func alert(title: String?, message: String?, leftActionTitle: String?, rightActionTitle: String?, callBack: @escaping (Int)->()) -> Void {
        alert(title: title, message: message, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, presentOn: UIApplication.shared.keyWindow?.rootViewController, callBack: callBack)
    }
    
    /// alert on viewcontroller with two action
    /// - Parameters:
    ///   - title: title
    ///   - message: message
    ///   - leftActionTitle: left title
    ///   - rightActionTitle: right title
    ///   - presentOn: on viewcontroller, default is window.rooterController
    ///   - callBack: call back
    /// - Returns: void
    class func alert(title: String?, message: String?, leftActionTitle: String?, rightActionTitle: String?, presentOn: UIViewController?, callBack: @escaping (Int)->()) -> Void {
        let alertVc = self.init(title: title, message: message, preferredStyle: .alert)
        let cancelAct = UIAlertAction.init(title: leftActionTitle, style: .cancel) { (action) in
            callBack(0)
        }
        let sureAct = UIAlertAction.init(title: rightActionTitle, style: .default) { (action) in
            callBack(1)
        }
        alertVc.addAction(cancelAct)
        alertVc.addAction(sureAct)
        
        presentOn?.present(alertVc, animated: true, completion: {
            
        })
    }
}

//
//  ViewController.swift
//  Mamba
//
//  Created by LuKane on 2020/11/25.
//

import UIKit

class Object: NSObject {
    var name: String = ""
    var age: String = ""
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        view.backgroundColor = .orange
        
        let objc = Object()
        objc.name = "1"
        
        print("\(String(describing: JudgeEmpty.isEmptyString(str: objc.name)))")
        
    }
}

class JudgeEmpty {
    class func isEmptyString(str: String?) -> Bool {
        guard str != nil else {
            return true
        }
        return str?.isEmpty ?? false
    }
    class func isEmptyArray(arr: [Any]?) -> Bool {
        guard arr != nil else {
            return true
        }
        return arr?.isEmpty ?? false
    }
}


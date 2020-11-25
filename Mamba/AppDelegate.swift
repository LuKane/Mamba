//
//  AppDelegate.swift
//  Mamba
//
//  Created by LuKane on 2020/11/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let vc = ViewController()
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        
        return true
    }
}


//
//  ViewController.swift
//  Mamba
//
//  Created by LuKane on 2020/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        let time = "2018-12-28 19:44:33"
        let date = Date.dateFromString(time, format: "YYYY-MM-dd HH:mm:ss")
        
        print("\(String(describing: date?.dateAddingDays(days: 3)))")
    }
}

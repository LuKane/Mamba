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
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        view.backgroundColor = .orange
    }
}

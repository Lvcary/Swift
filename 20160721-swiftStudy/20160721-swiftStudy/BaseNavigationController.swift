//
//  BaseNavigationController.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/21.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        print(self.viewControllers.count)
        
        if self.viewControllers.count > 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
    }
    
}

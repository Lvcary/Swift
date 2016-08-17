//
//  BaseTabBarController.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/21.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 首页
        let viewController : ViewController = ViewController()
        let navi : BaseNavigationController = BaseNavigationController.init(rootViewController: viewController)
        navi.tabBarItem.title = "home"
        navi.tabBarItem.image = UIImage(imageLiteral: "tab_estate_nor")
        
        // 第二页
        let secondVC : SecondViewController = SecondViewController()
        let secondNavi : BaseNavigationController = BaseNavigationController.init(rootViewController: secondVC)
        secondNavi.tabBarItem.title = "second"
        secondNavi.tabBarItem.image = UIImage(imageLiteral: "tab_personalCenter_nor")
        
        // 第三页
        let third : ThirdViewController = ThirdViewController()
        let thirdNavi : BaseNavigationController = BaseNavigationController.init(rootViewController: third)
        thirdNavi.tabBarItem.title = "Third"
        thirdNavi.tabBarItem.image = UIImage(imageLiteral: "tab_store_nor")
        
        let controllerArray : NSArray = NSArray.init(objects: navi,secondNavi,thirdNavi)
        
        self.viewControllers = NSArray(array: controllerArray) as? [BaseNavigationController]
        
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = mainColor
        
    }
}

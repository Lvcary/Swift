//
//  NavigationExtension.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/22.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import Foundation
import UIKit

var key : String = "coverView"
// MARK: - 修改导航栏颜色
extension UINavigationBar {
   
    var coverView : UIView? {
        get{
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        set{
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func lk_setBackgroundColor(color:UIColor) {
        
        if self.coverView != nil {
            self.coverView?.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.shadowImage = UIImage()
            
            let over = UIView.init(frame: CGRectMake(0, -20, KSCWidth, CGRectGetHeight(self.bounds)+20))
            over.userInteractionEnabled = false
            over.autoresizingMask = .FlexibleWidth
            self.insertSubview(over, atIndex: 0)
            
            over.backgroundColor = color
            self.coverView = over
        }
    }
}


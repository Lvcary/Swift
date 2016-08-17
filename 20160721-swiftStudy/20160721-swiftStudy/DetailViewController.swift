//
//  DetailViewController.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/21.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

/**
 *  d代理
 */
public protocol DeatilDelegate {
    
    func conformDetail(name : String, andContent content : String)
}

class DetailViewController: BaseViewController {
    
    var delegate : DeatilDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 100/255.0, green: 110/255.0, blue: 200/255.0, alpha: 1)
        
        let btn : UIButton = UIButton.init(type: UIButtonType.System)
        btn.frame = CGRectMake(20, 80, 100, 30)
        btn.setTitle("touch me", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.blackColor().CGColor
        btn.addTarget(self, action: Selector("btnAction"), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
    }
    
    func btnAction() {
        self.delegate?.conformDetail("jobs", andContent: "学习swfit")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}


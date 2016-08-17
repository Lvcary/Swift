//
//  CategoryDetailTabVC.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/26.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class CategoryDetailTabVC: BaseTableViewController {
    
    var categoryDetailArray : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    //MARK:- tableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryDetailArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indefiter : String = "cell"
        let cell : NDProductListCell = NDProductListCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: indefiter)
        
        cell.accessoryType = .DisclosureIndicator
        
        let categoryDic : NSDictionary = self.categoryDetailArray[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = categoryDic["categoryName"] as? String
        cell.textLabel?.font = UIFont.systemFontOfSize(13)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

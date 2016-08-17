//
//  SecondViewController.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/21.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "second"
        
        tableView = UITableView.init(frame: CGRectMake(0, 0, KSCWidth, KSCHeight), style: .Plain)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        tableView.mj_header = MJRefreshHeader.init(refreshingTarget: self, refreshingAction: Selector("loadDataAction"))
        tableView.mj_header.beginRefreshing()
    }
    
    // 
    func loadDataAction(){
        print("333")
        self.tableView.mj_header.endRefreshing()
    }
    
    
    //MARK:-   tableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indefiter = "cell"
        let cell : UITableViewCell = UITableViewCell.init(style: .Default, reuseIdentifier: indefiter)
        
        cell.textLabel?.text = String(format: "indexPath.row = %ld" ,indexPath.row)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let productList : ProductListVC = ProductListVC()
        productList.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productList, animated: true)
    }
}

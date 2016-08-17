//
//  CategoryTabVC.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/26.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class CategoryTabVC: BaseTableViewController {

    var dataSource : NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Category"
        self.navigationController?.navigationBar.lk_setBackgroundColor(mainColor)
        
        self.dataSource = NSMutableArray()
        self.tableView.tableFooterView = UIView()
        self.loadCategoryRequest()
    }
    
    override func viewWillDisappear(animated: Bool) {

        SVProgressHUD.dismiss()
    }
    
    // 数据请求
    func loadCategoryRequest() {
        
        SVProgressHUD.show()
        let ndNetwork : NDNetWorking = NDNetWorking()
        let param : NSDictionary = NSDictionary.init(object: "1", forKey: "catType")
        
        ndNetwork.postRequestWithUrl(String("http://"+(NDC_id)+"/app/catalog.html"), andParam: param, finish: { (finishResult) -> Void in
            
            let json = finishResult as! NSDictionary
            
            let catalog = json["catalog"] as! NSArray
            
            for categoryDic in catalog {
                self.dataSource.addObject(Category.mj_objectWithKeyValues(categoryDic))
            }
            
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
            }) { (faildResult) -> Void in
                SVProgressHUD.showWithStatus(faildResult.debugDescription)
        }
    }
    
    //MARK:- tableViewDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indefiter : String = "cell"
        let cell : NDProductListCell = NDProductListCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: indefiter)
        
        cell.accessoryType = .DisclosureIndicator
        
        let categoryModel = self.dataSource[indexPath.row] as! Category
        
        cell.textLabel?.text = categoryModel.categoryName as String
        cell.textLabel?.font = UIFont.systemFontOfSize(13)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let categoryModel = self.dataSource[indexPath.row] as! Category
        let categoryDetailArray : NSArray = categoryModel.childs
        
        let categoryDetail : CategoryDetailTabVC = CategoryDetailTabVC()
        categoryDetail.categoryDetailArray = categoryDetailArray
        self.navigationController?.pushViewController(categoryDetail, animated: true)
    }
    
    deinit {
        print("222")
    }
}

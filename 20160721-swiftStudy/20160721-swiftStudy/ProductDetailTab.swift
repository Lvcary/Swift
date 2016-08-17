//
//  ProductDetailTab.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/28.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class ProductDetailTab: BaseTableViewController,SDCycleScrollViewDelegate {

    // 商品名称
    var productName : NSString!
    // 商品id
    var productId : NSString!
    
    // 数据源
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.productName as String
        
        self.loadProductDetailRequest()
    }
    
    //MARK:- 数据请求
    func loadProductDetailRequest(){
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let param : NSDictionary = NSDictionary.init(objects: [self.productId,"1180"], forKeys: ["productId","userId"])
        let request : NDNetWorking = NDNetWorking()
        request.productDetailRequestWith(param, finish: { (finishResult) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            let json = finishResult as! NSDictionary
            
            
            let imageArray : NSArray = json["images"] as! NSArray
            if imageArray.count > 0 {
                self.setSdyScrollViewWithArray(imageArray)
            }
            
            let product : Products = Products.mj_objectWithKeyValues(json)
//            print("json = ",json)
            print("product = ",product)
            
            
            }) { (faildResult) -> Void in
                
        }
        
    }
    
    //MARK:- tableViewdelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indefiter = "cell"
        let cell : UITableViewCell = UITableViewCell.init(style: .Default, reuseIdentifier: indefiter)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 12
        }else {
            return 2
        }
    }
    
    //MARK:- SDCycleScrollView  轮播图
    func setSdyScrollViewWithArray(imageArray : NSArray) -> Void {
        
        let cycleScrollview : SDCycleScrollView = SDCycleScrollView(frame: CGRectMake(0, -64, KSCWidth, 200), imageURLStringsGroup: imageArray as [AnyObject])
        cycleScrollview.delegate = self
        self.tableView.tableHeaderView = cycleScrollview
        
        // 清楚缓存
        cycleScrollview.clearCache()
        
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        print("index = ",index)
        
        
        
    }
}

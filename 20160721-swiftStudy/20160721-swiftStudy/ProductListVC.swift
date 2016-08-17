//
//  ProductListVC.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/28.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class ProductListVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    // tableview
    var tableView : UITableView!
    
    // 产品数据源
    var dataSource : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "productList"
        
        self.navigationController?.navigationBar.lk_setBackgroundColor(mainColor)
        
        // 设置title为白色
        let navigationTitleAtt : NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAtt as? [String : AnyObject]
        
        self.dataSource = NSMutableArray()
        
        self.loadTableViewAction()
        
        self.loadProductsRequest()
    }
    
    func loadHeadView() {
        
    }
    
    func loadTableViewAction() {
        
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, KSCWidth, KSCHeight), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = UIView()
        self.view.addSubview(self.tableView)
    }
    
    func loadProductsRequest() {
        
        SVProgressHUD.show()
        let param : NSDictionary = NSDictionary(objects: ["1","","1","1180"], forKeys: ["categoryId","keywords","pageNo","userId"])
        let ndNetworking : NDNetWorking = NDNetWorking()
        ndNetworking.productListRequestWith(param, finish: { (finishResult) -> Void in
            
            let result = finishResult as! NSDictionary
//            print(result)
            
            let productsArray = result["products"]
            for product in productsArray as! Array<NSDictionary>{
                
                self.dataSource.addObject(Products.mj_objectWithKeyValues(product))
            }
            
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
            
            }) { (faildResult) -> Void in
                SVProgressHUD.showWithStatus(faildResult.description as String)
        }
    }
    
    //MARK:- tableDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indefiter = "cell"
        
        let cell : NDProductListCell = NDProductListCell.init(style: .Default, reuseIdentifier: indefiter)
        
        
        let product : Products = self.dataSource[indexPath.row] as! Products
        cell.productHeadImage.sd_setImageWithURL(NSURL.init(string: product.mediaUrl as String))
        
        
        //        cell.productPrice.text = String("FOB Price："+(product.fobPrice as String))
        //        cell.productMinOrder.text = String(format: "最低订单：%@" , product.minOrder)
        //        cell.productMinOrder.text = String("Min Order："+(product.minOrder as String))
        
        //
        let priceAtt : NSMutableAttributedString = NSMutableAttributedString.init(string: String("FOB Price："+(product.fobPrice as String)))
        priceAtt.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSRange.init(location: 9, length: priceAtt.length - 9))
        cell.productPrice.attributedText = priceAtt
        
        // 字段高亮
        let attString : NSMutableAttributedString = NSMutableAttributedString.init(string: String("Min Order："+(product.minOrder as String)))
        attString.addAttribute(NSForegroundColorAttributeName, value: mainColor, range: NSRange.init(location: 9, length: attString.length - 9))
        
        cell.productMinOrder.attributedText = attString
        
        
        cell.setProductNameStr(product.productName as String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let product : Products = self.dataSource[indexPath.row] as! Products
        let productDetail : ProductDetailTab = ProductDetailTab()
        productDetail.productName = product.productName
        productDetail.productId = String(product.productId)
        self.navigationController?.pushViewController(productDetail, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 83
    }
}

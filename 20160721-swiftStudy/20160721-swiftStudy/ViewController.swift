//
//  ViewController.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/21.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,DeatilDelegate,UITextFieldDelegate,SDCycleScrollViewDelegate {

    // 设置tableview属性
    var tableView : UITableView!
    // 数据源
    var dataSource : NSMutableArray!
    // 广告轮播图数据源
    var rolling_ad_Array : NSMutableArray!
    // 搜索栏
    var searchText : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadHeadView()
        self.loadTableView()
        self.rolling_ad_Array = NSMutableArray()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        dataSource = NSMutableArray.init(array: UIFont.familyNames())
        
        // 数据请求
        self.loadDataRequest()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.scrollViewDidScroll(self.tableView)
    }
    
    //MARK:-  头view
    func loadHeadView() {
        self.view.backgroundColor = UIColor.redColor()
        
        // 设置title为白色
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "category"), style: .Plain, target: self, action: "leftItemAction")
        
        searchText  = UITextField.init(frame: CGRectMake(0, 0, KSCWidth - 90, 30))
        searchText.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
        searchText.layer.borderWidth = 1
        searchText.layer.borderColor = UIColor.whiteColor().CGColor
        searchText.layer.masksToBounds = true
        searchText.layer.cornerRadius = 4
        searchText.delegate = self
        
        let leftimage : UIImageView = UIImageView.init(frame: CGRectMake(10, 0, 38 * 0.8, 33 * 0.8))
        leftimage.image = UIImage(named: "searchRight")
        leftimage.alpha = 0.7
        leftimage.backgroundColor = UIColor.orangeColor()
        searchText.leftView = leftimage
        searchText.leftViewMode = .Always
        self.navigationItem.titleView = searchText
        
        self.navigationController?.navigationBar.lk_setBackgroundColor(UIColor.init(colorLiteralRed: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.05))
    }
    
    //MARK:- 数据请求
    func loadDataRequest() {
        
        let ndNetwork : NDNetWorking = NDNetWorking()
        ndNetwork.postRequestWithUrl(String("http://"+(NDC_id)+"/app/index.html"), andParam: NSDictionary(), finish: { (finishResult) -> Void in
            
            let json = finishResult as! NSDictionary
            
            let rolling_ad = json.objectForKey("index_rolling_ad")
            
            let imageArray : NSMutableArray = NSMutableArray()
            
            for  adDic in rolling_ad as! Array<NSDictionary> {
                
                /// 根据字典生成数据模型
                self.rolling_ad_Array.addObject(Rolling_ad.mj_objectWithKeyValues(adDic))
                
                imageArray.addObject(adDic["mediaUrl"]!)
            }
            
            self.setSdyScrollViewWithArray(imageArray)
            
            }) { (faildResult) -> Void in
                
        }
    }
    
    
    //MARK:- tableView
    func loadTableView() {
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 49), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    // 左边的点击按钮方法
    func leftItemAction(){
        print("left")
        
        let categoryTableVC : CategoryTabVC = CategoryTabVC()
        categoryTableVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(categoryTableVC, animated: true)
        
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
    
    //MARK:- tableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let indefiter : String = "cell"
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: indefiter)
        cell.textLabel?.text = dataSource[indexPath.row] as? String
        cell.imageView?.image = UIImage(imageLiteral: "tab_home_pre")
        
        // 修改image的大小
        let itemSize : CGSize = CGSizeMake(29.5*1.5, 22.5*1.5)
        UIGraphicsBeginImageContext(itemSize)
        let imageRect : CGRect = CGRectMake(0, 0, itemSize.width, itemSize.height)
        cell.imageView?.image?.drawInRect(imageRect)
        cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row % 2 == 0 {
            // 偶数时跳转
            let detail : DetailViewController = DetailViewController()
            detail.delegate = self
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
        }else {
            
            // 奇数时展示
            
            let alert : UIAlertView = UIAlertView.init(title: "标题", message: dataSource[indexPath.row] as? String, delegate: nil, cancelButtonTitle: "确定")
            alert.show()

            
            /*
            let alert : UIAlertController = UIAlertController.init(title: "标题", message: String("字体是：", dataSource[indexPath.row] as! String), preferredStyle: .Alert)
            let action : UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
            */
        }
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let y : CGFloat = scrollView.contentOffset.y
        if y <= 0 {
        
            searchText.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
            self.navigationController?.navigationBar.lk_setBackgroundColor(UIColor.init(colorLiteralRed: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.05))
        }else if (y > 0 && y < 154) {
            
            let distion : CGFloat = 164
            let dis :Float =  Float((y)/distion)
            searchText.backgroundColor = UIColor.init(white: 1, alpha: CGFloat(dis*0.3 + 0.7))
            
            self.navigationController?.navigationBar.lk_setBackgroundColor(UIColor.init(colorLiteralRed: (51 - dis * 15)/255.0, green: (51 + dis * 10)/255.0, blue: (51 + dis * 90)/255.0, alpha: 0.05 + dis * 0.95))
            
        }else {
            self.navigationController?.navigationBar.lk_setBackgroundColor(mainColor)
            searchText.backgroundColor = UIColor.init(white: 1, alpha: 1)
        }
    }
    
    //MARK:- textFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("search")
        return false
    }
    
    func conformDetail(name: String, andContent content: String) {
        print(name, "is now",content )
    }
}


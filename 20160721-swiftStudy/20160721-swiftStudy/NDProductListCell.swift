//
//  NDProductListCell.swift
//  20160721-swiftStudy
//
//  Created by 刘康蕤 on 16/7/22.
//  Copyright © 2016年 刘康蕤. All rights reserved.
//

import UIKit

class NDProductListCell: BaseTableCell {
    
    /// 头像
    var productHeadImage : UIImageView!
    /// 产品名称
    var productName : UILabel!
    /// 价格
    var productPrice : UILabel!
    /// 最低订单
    var productMinOrder : UILabel!
    /// 匹配度
    var productMatch : UILabel!
    
    
    let cellHeight = 76
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        productHeadImage = UIImageView.init(frame: CGRectMake(8, 8, 60, 60))

        productName = UILabel.init(frame: CGRectMake(76, 5, KSCWidth - 76 - 8, 34))
        productName.font = UIFont.systemFontOfSize(14)
        
        productPrice = UILabel.init(frame: CGRectMake(76, 34, KSCWidth - 84, 25))
        productPrice.font = UIFont.systemFontOfSize(12)
        
        productMinOrder = UILabel.init(frame: CGRectMake(76, 60, KSCWidth - 84, 15))
        productMinOrder.font = UIFont.systemFontOfSize(12)
        
        self.contentView.addSubview(productHeadImage)
        self.contentView.addSubview(productName)
        self.contentView.addSubview(productPrice)
        self.contentView.addSubview(productMinOrder)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductNameStr(productNameStr : NSString) {
        
        self.productName.text = productNameStr as String
        
        let att : NSDictionary = NSDictionary.init(object: UIFont.systemFontOfSize(14), forKey: NSFontAttributeName)
        
        let size = productNameStr.boundingRectWithSize(CGSizeMake(KSCWidth - 74, CGFloat(MAXFLOAT)), options: .UsesDeviceMetrics, attributes: att as? [String : AnyObject], context: nil)
        
        if size.height > 11{
            productName.numberOfLines = 2
        }
    }
}
